# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class GiropaySource < PaymentSource
      def initialize
        super CheckoutSdk::Common::PaymentSourceType::GIROPAY
      end
    end
  end
end
