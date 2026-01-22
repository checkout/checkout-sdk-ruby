# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class CurrencyAccountSource < PayoutSource
      def initialize
        super(PayoutSourceType::CURRENCY_ACCOUNT)
      end
    end
  end
end
