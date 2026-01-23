# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      class AlipaySource < PaymentSource
        def initialize
          super(CheckoutSdk::Common::PaymentSourceType::ALIPAY)
        end
      end
    end
  end
end
