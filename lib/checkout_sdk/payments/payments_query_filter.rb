# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute limit
    #   @return [Integer]
    # @!attribute skip
    #   @return [Integer]
    # @!attribute reference
    #   @return [String]
    class PaymentsQueryFilter
      attr_accessor :limit,
                    :skip,
                    :reference
    end
  end
end
