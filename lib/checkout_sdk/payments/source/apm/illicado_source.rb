# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address]
    class IllicadoSource < PaymentSource
      attr_accessor :billing_address

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::ILLICADO
      end
    end
  end
end
