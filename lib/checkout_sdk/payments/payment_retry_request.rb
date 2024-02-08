# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute enabled
    #   @return [TrueClass, FalseClass]
    # @!attribute max_attempts
    #   @return [Integer]
    # @!attribute end_after_days
    #   @return [Integer]
    class PaymentRetryRequest
      attr_accessor :enabled,
                    :max_attempts,
                    :end_after_day
    end
  end
end
