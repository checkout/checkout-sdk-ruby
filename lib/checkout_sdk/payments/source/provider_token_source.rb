# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute payment_method
    #   @return [String]
    # @!attribute token
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class ProviderTokenSource < PaymentSource
      attr_accessor :payment_method,
                    :token,
                    :account_holder

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::PROVIDER_TOKEN)
      end
    end
  end
end
