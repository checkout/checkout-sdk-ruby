require "checkout/configuration"
require "checkout/api_resource"
require "checkout/data/capture_payment"
require "checkout/data/payment_request_source"

module Checkout
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
