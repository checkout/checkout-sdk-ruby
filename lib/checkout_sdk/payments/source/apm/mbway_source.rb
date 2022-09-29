# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class MbwaySource < PaymentRequestSource
      def initialize
        super CheckoutSdk::Common::PaymentSourceType::MBWAY
      end
    end
  end
end
