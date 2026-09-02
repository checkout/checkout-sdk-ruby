# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Vipps source.
    #
    # The schema declares no properties beyond `type`.
    class VippsSource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::VIPPS)
      end
    end
  end
end
