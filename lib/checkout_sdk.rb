require "checkout_sdk/configuration"
require "checkout_sdk/api_resource"
require "checkout_sdk/data/capture_payment"
require "checkout_sdk/data/payment_request_source"

module CheckoutSdk
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
