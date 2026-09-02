# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # TWINT source.
    #
    # The schema declares no properties beyond `type`.
    class TwintSource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::TWINT)
      end
    end
  end
end
