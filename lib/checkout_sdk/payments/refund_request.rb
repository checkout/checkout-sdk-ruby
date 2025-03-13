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
    #   @return [Array(CheckoutSdk::Common::AmountAllocations)]
    # @!attribute capture_action_id
    #   @return [String]
    # @!attribute destination
    #   @return [CheckoutSdk::Common::Destination]
    # @!attribute items
    #   @return [Array(CheckoutSdk::Payments::RefundOrder)]
    class RefundRequest
      attr_accessor :amount,
                    :reference,
                    :metadata,
                    :amount_allocations,
                    :capture_action_id,
                    :destination,
                    :items
    end
  end
end
