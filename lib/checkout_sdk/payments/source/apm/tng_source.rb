# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Touch n Go source.
    #
    # The schema declares no properties beyond `type`.
    class TngSource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::TNG)
      end
    end
  end
end
