# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute id
    #   @return [String]
    # @!attribute cvv
    #   @return [String]
    class IdSource < RiskPaymentSource
      attr_accessor :id,
                    :cvv

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::ID
      end
    end
  end
end
