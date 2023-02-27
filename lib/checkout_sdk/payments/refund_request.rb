# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute amount
    #   @return [Integer]
    # @!attribute reference
    #   @return [String]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    # @!attribute amount_allocations
    #   @return [Array(CheckoutSdk::Common::AmountAllocations)] - Not available on Previous.
    class RefundRequest
      attr_accessor :amount,
                    :reference,
                    :metadata,
                    :amount_allocations
    end
  end
end
