# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute purpose
    #   @return [String]
    class EPSSource < PaymentSource
      attr_accessor :purpose

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::EPS)
      end
    end
  end
end
