# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute type
    #   @return [String] {PayoutSourceType}
    # @!attribute id
    #   @return [String]
    # @!attribute amount
    #   @return [String]
    class PayoutSource
      attr_reader :type
      attr_accessor :id,
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
