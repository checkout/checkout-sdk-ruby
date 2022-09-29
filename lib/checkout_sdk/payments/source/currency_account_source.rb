# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute id
    #   @return [String]
    class CurrencyAccountSource < PayoutRequestSource
      attr_accessor :id

      def initialize
        super PayoutSourceType::CURRENCY_ACCOUNT
      end
    end
  end
end
