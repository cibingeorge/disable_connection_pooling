require 'active_record/base'

class ActiveRecord::Base
  def self.disable_connection_pooling=(disable)
    require 'disable_connection_pooling/railtie' if disable
  end
end
