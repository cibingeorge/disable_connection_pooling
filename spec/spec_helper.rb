require 'mysql2'

def mysql
  client = Mysql2::Client.new(host: '127.0.0.1', username: 'root')

  begin
    retval = yield(client)
  ensure
    client.close
  end

  return retval
end

def processlist
  mysql do |client|
    rows = client.query("SHOW PROCESSLIST").to_a
    rows.select {|i| i['db'] }
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

RSpec.configure do |config|
  config.before(:each) do
    killall
  end
end
