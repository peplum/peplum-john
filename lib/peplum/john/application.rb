# frozen_string_literal: true

require 'peplum'

module Peplum
class John

class Application < Peplum::Application
  require_relative "application/payload"

  provision_memory 100 * 1024 * 1024
  provision_disk   100 * 1024 * 1024

  def payload
    Payload
  end

end

end
end
