module DisableConnectionPooling
  NUMBER_OF_REQUESTS_KEY = :disable_connection_pooling_number_of_requests

  def self.disconnect?
    return true unless ActiveRecord::Base.number_of_requests_to_disconnecting

    Thread.current[NUMBER_OF_REQUESTS_KEY] ||= ActiveRecord::Base.number_of_requests_to_disconnecting
    num = Thread.current[NUMBER_OF_REQUESTS_KEY]
    num -= 1

    if num.zero?
      Thread.current[NUMBER_OF_REQUESTS_KEY] = ActiveRecord::Base.number_of_requests_to_disconnecting
    end
  end
end

require 'disable_connection_pooling/version'
require 'disable_connection_pooling/active_record_base'
