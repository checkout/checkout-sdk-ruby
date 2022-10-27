# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute type
    #   @return [String] {CheckoutSdk::Common::PaymentSourceType}
    class PaymentSource
      attr_reader :type

      protected

      # @abstract
      # @param [String] type {CheckoutSdk::Common::PaymentSourceType}
      def initialize(type)
        @type = type
      end
    end
  end
end
