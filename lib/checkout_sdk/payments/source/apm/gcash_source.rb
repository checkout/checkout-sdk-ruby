# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # GCash source.
    #
    # The schema declares no properties beyond `type`.
    class GcashSource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::GCASH)
      end
    end
  end
end
