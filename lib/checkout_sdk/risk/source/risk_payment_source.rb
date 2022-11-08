# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute type
    #   @return [String] {CheckoutSdk::Common::PaymentSourceType}
    class RiskPaymentSource
      attr_reader :type

      protected

      # @abstract
      # @param [String]  {CheckoutSdk::Common::PaymentSourceType}
      def initialize(type)
        @type = type
      end
    end
  end
end
