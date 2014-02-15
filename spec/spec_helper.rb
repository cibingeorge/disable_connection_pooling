require 'mysql2'
require 'net/http'
require 'json'
require 'tempfile'

RSpec.configure do |config|
  config.before(:each) do
    killall
    expect(processlist.length).to eq(0)
  end
end

def mysql
  client = Mysql2::Client.new(host: '127.0.0.1', username: 'root')

  begin
    retval = yield(client)
  ensure
    client.close
  end

  return retval
end

def processlist(db = nil)
  mysql do |client|
    rows = client.query("SHOW PROCESSLIST").to_a
    rows.select {|i| db ? i['db'] == db : i['db'] }
  end
end

def killall
  mysql do |client|
    rows = client.query("SHOW PROCESSLIST").to_a

    rows.select {|i| i['db'] }.each do |i|
      client.query("KILL #{i['Id']}")
    end
  end
end

def send_request(port)
  Net::HTTP.start('127.0.0.1', port) do |http|
    http.get('/items')
  end
end

def tempfile(content)
  Tempfile.open("#{File.basename __FILE__}.#{$$}") do |f|
    f << content
    f.flush
    f.rewind
    yield(f)
  end
end

def run_script(port, script)
  tempfile(script) do |f|
    Net::HTTP.start('127.0.0.1', port) do |http|
      http.get("/run?file=#{f.path}").body
    end
  end
end
