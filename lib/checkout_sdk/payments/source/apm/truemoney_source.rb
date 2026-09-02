# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # TrueMoney source.
    #
    # The schema declares no properties beyond `type`.
    class TruemoneySource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::TRUEMONEY)
      end
    end
  end
end
