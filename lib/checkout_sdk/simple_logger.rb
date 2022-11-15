# frozen_string_literal: true

module CheckoutSdk
  class SimpleLogger
    attr_reader :logger

    def initialize(min_level = Logger::INFO)
      @logger = Logger.new($stdout)
      @logger.level = min_level
    end
  end
end
