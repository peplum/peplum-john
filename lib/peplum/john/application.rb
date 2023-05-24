# frozen_string_literal: true

require 'peplum'

module Peplum
class John

class Application < Peplum::Application
  require_relative "application/payload"

  provision_memory 100 * 1024 * 1024
  provision_disk   100 * 1024 * 1024

  require_relative "application/services/info"
  instance_service_for :info, Services::Info

  require_relative "application/services/rest_proxy"
  rest_service_for :info, Services::RESTProxy

  def payload
    Payload
  end

end

end
end
