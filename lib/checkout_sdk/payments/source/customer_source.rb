# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute id
    #   @return [String]
    class CustomerSource < PaymentSource
      attr_accessor :id

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::CUSTOMER
      end
    end
  end
end
