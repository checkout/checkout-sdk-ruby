# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class PayPalSource < PaymentRequestSource
      def initialize
        super CheckoutSdk::Common::PaymentSourceType::PAYPAL
      end
    end
  end
end
