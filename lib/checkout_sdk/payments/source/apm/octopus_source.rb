# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class OctopusSource < PaymentSource
      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::OCTOPUS)
      end
    end
  end
end
