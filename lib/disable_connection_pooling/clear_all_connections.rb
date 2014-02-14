class DisableConnectionPooling::ClearAllConnections
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  ensure
    if DisableConnectionPooling.disconnect?
      ActiveRecord::Base.clear_all_connections!
    end
  end
end
