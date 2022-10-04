# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute countryCode
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute languageCode
    #   @return [String]
    class SofortSource < PaymentSource
      attr_accessor :countryCode,
                    :languageCode

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::SOFORT
      end
    end
  end
end
