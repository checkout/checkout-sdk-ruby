# frozen_string_literal: true

module CheckoutSdk
  module Common
    # Configures the parameters for customer retries. A customer retry is a payment attempt
    # performed by the customer on the checkout page, used by hosted payments, payment links
    # and payment sessions.
    #
    # @!attribute max_attempts
    #   @return [Integer] [Optional] The maximum number of customer retry attempts, excluding the
    #     initial payment attempt. Minimum 0, maximum 5. Default 5.
    #     Required when used in a payment sessions request.
    class CustomerRetry
      attr_accessor :max_attempts
    end
  end

  module Accounts
    # @deprecated Please use {CheckoutSdk::Common::CustomerRetry} instead. This alias will be
    #   removed in the next major version.
    CustomerRetry = CheckoutSdk::Common::CustomerRetry
  end
end
