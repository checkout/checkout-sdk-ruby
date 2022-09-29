# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute type
    #   @return [String] {CheckoutSdk::Common::PaymentSourceType}
    class PaymentRequestSource
      attr_reader :type

      protected

      # @param [String] type {CheckoutSdk::Common::PaymentSourceType}
      def initialize(type)
        @type = type
      end
    end
  end
end
