# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Alipay CN source.
    #
    # The schema declares no properties beyond `type`.
    class AlipayCnSource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::ALIPAY_CN)
      end
    end
  end
end
