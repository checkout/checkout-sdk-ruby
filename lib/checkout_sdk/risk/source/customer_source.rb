# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute id
    #   @return [String]
    class CustomerSource < RiskPaymentSource
      attr_accessor :id

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::CUSTOMER)
      end
    end
  end
end
