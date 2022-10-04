# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class KlarnaSource < PaymentSource
      attr_accessor :account_holder

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::KLARNA
      end
    end
  end
end
