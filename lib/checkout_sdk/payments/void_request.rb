# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute amount
    #   @return [Integer] the amount to void, min 0, max 9999999999.
    #     If not specified, the full payment amount is voided.
    # @!attribute reference
    #   @return [String]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    class VoidRequest
      attr_accessor :amount,
                    :reference,
                    :metadata
    end
  end
end
