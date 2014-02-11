require 'active_record/railtie'
require 'disable_connection_pooling/clear_all_connections'

class DisableConnectionPooling::Railtie < Rails::Railtie
  config.app_middleware.delete 'ActiveRecord::QueryCache'
  config.app_middleware.swap 'ActiveRecord::ConnectionAdapters::ConnectionManagement', 'DisableConnectionPooling::ClearAllConnections'

  config.after_initialize do
    ActiveRecord::Base.clear_all_connections!
  end
end
