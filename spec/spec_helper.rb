require 'mysql2'
require 'net/http'

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

RSpec.configure do |config|
  config.before(:each) do
    killall
    expect(processlist.length).to eq(0)
  end
end
