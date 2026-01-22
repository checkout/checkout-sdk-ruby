# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute token
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class PlaidSource < PaymentSource
      attr_accessor :token, :account_holder

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::PLAID)
      end
    end
  end
end
