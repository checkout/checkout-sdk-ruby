# frozen_string_literal: true

module CheckoutSdk
  module AgenticCommerce
    # Card payment-method block used inside a {DelegatedPaymentRequest}.
    #
    # @!attribute type
    #   @return [String] "card"
    # @!attribute card_number_type
    #   @return [String] Either "fpan" or "network_token".
    # @!attribute number
    #   @return [String]
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    # @!attribute name
    #   @return [String]
    # @!attribute cvc
    #   @return [String]
    # @!attribute cryptogram
    #   @return [String]
    # @!attribute eci
    #   @return [String]
    # @!attribute card_funding
    #   @return [String] e.g. "credit", "debit", "prepaid".
    class DelegatedPaymentMethodCard
      attr_accessor :type,
                    :card_number_type,
                    :number,
                    :expiry_month,
                    :expiry_year,
                    :name,
                    :cvc,
                    :cryptogram,
                    :eci,
                    :card_funding

      def initialize
        @type = 'card'
      end
    end
  end
end
