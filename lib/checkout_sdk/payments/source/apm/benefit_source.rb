# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class BenefitSource < PaymentRequestSource
      def initialize
        super CheckoutSdk::Common::PaymentSourceType::BENEFIT
      end
    end
  end
end
