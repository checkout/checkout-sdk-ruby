# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Alipay HK source.
    #
    # The schema declares no properties beyond `type`.
    class AlipayHkSource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::ALIPAY_HK)
      end
    end
  end
end
