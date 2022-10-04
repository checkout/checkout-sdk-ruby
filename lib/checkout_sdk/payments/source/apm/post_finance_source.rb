# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute payment_country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute account_holder_name
    #   @return [String]
    # @!attribute billing_descriptor
    #   @return [String]
    class PostFinanceSource < PaymentSource
      attr_accessor :payment_country,
                    :account_holder_name,
                    :billing_descriptor

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::POSTFINANCE
      end
    end
  end
end
