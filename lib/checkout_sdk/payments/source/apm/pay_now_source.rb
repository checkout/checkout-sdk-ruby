# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # PayNow source.
    #
    # The schema declares no properties beyond `type`.
    class PayNowSource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::PAYNOW)
      end
    end
  end
end
