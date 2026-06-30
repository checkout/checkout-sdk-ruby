# frozen_string_literal: true

module CheckoutSdk
  module AgenticCommerce
    # Card payment-method block used inside a {DelegatedPaymentRequest}.
    # Mirrors swagger `DelegatedPaymentMethodCard`. Required fields per spec:
    # `type`, `card_number_type`, `number`, `metadata`.
    #
    # @!attribute type
    #   @return [String] Always "card".
    # @!attribute card_number_type
    #   @return [String] Either "fpan" or "network_token".
    # @!attribute number
    #   @return [String] The full card number.
    # @!attribute exp_month
    #   @return [String] Two-digit expiry month (MM).
    # @!attribute exp_year
    #   @return [String] Four-digit expiry year (YYYY).
    # @!attribute name
    #   @return [String] Cardholder name.
    # @!attribute cvc
    #   @return [String] Card verification code.
    # @!attribute cryptogram
    #   @return [String] Cryptogram for network-token transactions.
    # @!attribute eci_value
    #   @return [String] ECI / Security Level Indicator value.
    # @!attribute checks_performed
    #   @return [Array<String>] Verification checks performed on the card.
    # @!attribute iin
    #   @return [String] Issuer Identification Number (BIN).
    # @!attribute display_card_funding_type
    #   @return [String] "credit", "debit", or "prepaid".
    # @!attribute display_wallet_type
    #   @return [String] Wallet type for display.
    # @!attribute display_brand
    #   @return [String] Card brand for display (e.g. "Visa").
    # @!attribute display_last4
    #   @return [String] Last four digits for display.
    # @!attribute metadata
    #   @return [Hash{String => String}] Key-value pairs; required per swagger.
    class DelegatedPaymentMethodCard
      attr_accessor :type,
                    :card_number_type,
                    :number,
                    :exp_month,
                    :exp_year,
                    :name,
                    :cvc,
                    :cryptogram,
                    :eci_value,
                    :checks_performed,
                    :iin,
                    :display_card_funding_type,
                    :display_wallet_type,
                    :display_brand,
                    :display_last4,
                    :metadata

      def initialize
        @type = 'card'
      end
    end
  end
end
