# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute bic
    #   @return [String]
    # @!attribute description
    #   @return [String]
    # @!attribute language
    #   @return [String]
    class IdealSource < PaymentRequestSource
      attr_accessor :bic,
                    :description,
                    :language

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::IDEAL
      end
    end
  end
end
