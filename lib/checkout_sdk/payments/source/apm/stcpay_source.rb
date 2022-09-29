# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class StcPaySource < PaymentRequestSource
      def initialize
        super CheckoutSdk::Common::PaymentSourceType::STCPAY
      end
    end
  end
end
