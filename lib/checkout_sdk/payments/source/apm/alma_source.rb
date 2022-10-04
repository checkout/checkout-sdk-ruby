# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address]
    class AlmaSource < PaymentSource
      attr_accessor :billing_address

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::ALMA
      end
    end
  end
end
