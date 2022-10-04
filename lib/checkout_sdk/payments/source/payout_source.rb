# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute type
    #   @return [String] {PayoutSourceType}
    # @!attribute amount
    #   @return [String]
    class PayoutSource
      attr_reader :type
      attr_accessor :amount

      protected

      # @abstract
      # @param [String] type {PayoutSourceType}
      def initialize(type)
        @type = type
      end
    end
  end
end
