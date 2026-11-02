# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Configuration of Downtime retries.
    #
    # @!attribute enabled
    #   @return [TrueClass, FalseClass] [Required] Indicates if Checkout.com retries the payment when it's declined
    #     due to issuer or acquirer downtime.
    class DowntimeRetryRequest
      attr_accessor :enabled
    end
  end
end
