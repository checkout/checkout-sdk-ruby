# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute id
    #   @return [String]
    # @!attribute cvv
    #   @return [String]
    # @!attribute payment_method
    #   @return [String]
    class IdSource < PaymentRequestSource
      attr_accessor :id,
                    :cvv,
                    :payment_method

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::ID
      end
    end
  end
end
