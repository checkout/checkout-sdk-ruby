# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute payment_country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute account_holder_name
    #   @return [String]
    # @!attribute billing_descriptor
    #   @return [String]
    # @!attribute language
    #   @return [String]
    class BancontactSource < PaymentSource
      attr_accessor :payment_country,
                    :account_holder_name,
                    :billing_descriptor,
                    :language

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::BANCONTACT
      end
    end
  end
end
