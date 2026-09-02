# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # MobilePay source.
    #
    # The schema declares no properties beyond `type`.
    class MobilePaySource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::MOBILEPAY)
      end
    end
  end
end
