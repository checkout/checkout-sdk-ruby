# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address]
    class WeChatPaySource < PaymentSource
      attr_accessor :billing_address

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::WECHATPAY)
      end
    end
  end
end
