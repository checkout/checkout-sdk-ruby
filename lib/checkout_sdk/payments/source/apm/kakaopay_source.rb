# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Kakao Pay source.
    #
    # The schema declares no properties beyond `type`.
    class KakaopaySource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::KAKAOPAY)
      end
    end
  end
end
