# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # DANA source.
    #
    # The schema declares no properties beyond `type`.
    class DanaSource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::DANA)
      end
    end
  end
end
