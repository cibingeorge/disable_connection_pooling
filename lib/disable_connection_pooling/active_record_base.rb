require 'active_record/base'

class ActiveRecord::Base
  class_attribute :number_of_requests_to_disconnecting, :instance_writer => false

  def self.disable_connection_pooling=(disable)
    require 'disable_connection_pooling/railtie' if disable
  end
end
