# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class StcPaySource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::STCPAY)
      end
    end
  end
end
