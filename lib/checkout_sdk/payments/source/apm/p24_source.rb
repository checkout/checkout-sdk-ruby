# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute payment_country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute account_holder_name
    #   @return [String]
    # @!attribute account_holder_email
    #   @return [String]
    # @!attribute billing_descriptor
    #   @return [String]
    class P24Source < PaymentSource
      attr_accessor :payment_country,
                    :account_holder_name,
                    :account_holder_email,
                    :billing_descriptor

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::P24
      end
    end
  end
end
