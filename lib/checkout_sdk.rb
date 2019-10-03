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

require "checkout_sdk/configuration"
require "checkout_sdk/api_resource"
require "checkout_sdk/data/capture_payment"
require "checkout_sdk/data/payment_request_source"
require "checkout_sdk/data/payment_source"
require "checkout_sdk/data/refund_payment"
require "checkout_sdk/data/request_token"
require "checkout_sdk/data/void_payment"
