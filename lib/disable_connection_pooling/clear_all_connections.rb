class DisableConnectionPooling::ClearAllConnections
  def initialize(app)
    @app = app
  end

  def call(env)
    ActiveRecord::Base.connection_pool.release_connection if ActiveRecord::Base.connection_pool.active_connection?
    @app.call(env)
  ensure
    ActiveRecord::Base.connection_pool.release_connection if ActiveRecord::Base.connection_pool.active_connection?
  end
end
