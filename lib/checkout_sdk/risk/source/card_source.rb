# frozen_string_literal: true

module CheckoutSdk
  module Risk
    # @!attribute number
    #   @return [String]
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    # @!attribute name
    #   @return [String]
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute phone
    #   @return [CheckoutSdk::Common::Phone]
    class CardSource < RiskPaymentSource
      attr_accessor :number,
                    :expiry_month,
                    :expiry_year,
                    :name,
                    :billing_address,
                    :phone

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::CARD
      end
    end
  end
end
