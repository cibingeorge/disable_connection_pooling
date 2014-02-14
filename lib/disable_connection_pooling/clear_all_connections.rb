class DisableConnectionPooling::ClearAllConnections
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  ensure
    ActiveRecord::Base.clear_all_connections!
  end
end
