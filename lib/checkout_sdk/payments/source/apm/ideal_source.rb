# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute description
    #   @return [String]
    # @!attribute language
    #   @return [String]
    class IdealSource < PaymentSource
      attr_accessor :description,
                    :language

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::IDEAL
      end
    end
  end
end
