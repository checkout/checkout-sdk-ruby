# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute type
    #   @return [String] {PayoutSourceType}
    # @!attribute amount
    #   @return [String]
    class PayoutRequestSource
      attr_accessor :type,
                    :amount

      protected

      # @abstract
      # @param [String] type {PayoutSourceType}
      def initialize(type)
        @type = type
      end
    end
  end
end
