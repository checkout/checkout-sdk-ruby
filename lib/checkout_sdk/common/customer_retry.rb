# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute max_attempts
    #   @return [Integer]
    class CustomerRetry
      attr_accessor :max_attempts
    end
  end
end
