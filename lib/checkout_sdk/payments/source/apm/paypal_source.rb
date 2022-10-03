# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute plan
    #   @return [BillingPlan]
    class PayPalSource < PaymentRequestSource
      attr_accessor :plan

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::PAYPAL
      end
    end
  end
end
