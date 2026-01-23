# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class AfterPaySource < PaymentSource
      attr_accessor :account_holder

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::AFTERPAY)
      end
    end
  end
end
