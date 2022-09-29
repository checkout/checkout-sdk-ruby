# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address]
    class TamaraSource < PaymentRequestSource
      attr_accessor :billing_address

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::TAMARA
      end
    end
  end
end
