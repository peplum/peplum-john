# frozen_string_literal: true

require 'peplum'

module Peplum
class John

  require_relative "john/version"

  class Error < Peplum::Error; end

  require_relative "john/application"

end
end
