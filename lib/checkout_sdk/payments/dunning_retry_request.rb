# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Configuration of Dunning retries.
    #
    # @!attribute enabled
    #   @return [TrueClass, FalseClass] [Required] Indicates if Checkout.com retries the payment when it's declined
    #     with a supported decline code.
    # @!attribute max_attempts
    #   @return [Integer] [Optional] The maximum number of authorization retry attempts, excluding the initial
    #     authorization. Minimum 1, maximum 15. Default 6.
    # @!attribute end_after_days
    #   @return [Integer] [Optional] The maximum number of days between the initial request and the final retry
    #     attempt. Minimum 1, maximum 60. Default 30.
    class DunningRetryRequest
      attr_accessor :enabled,
                    :max_attempts,
                    :end_after_days
    end
  end
end
