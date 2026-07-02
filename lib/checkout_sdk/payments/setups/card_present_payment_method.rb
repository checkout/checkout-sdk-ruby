# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Card Present payment method configuration on a Payment Setup. Maps swagger `CardPresent`.
    #
    # @!attribute status
    #   @return [String] (response-only) Payment method status.
    # @!attribute flags
    #   @return [Array(String)] (response-only) Diagnostic flags returned by the API.
    # @!attribute track2
    #   @return [String] The Track 2 data read from card or device.
    # @!attribute emv
    #   @return [String] The EMV data read from the card or device.
    # @!attribute entry_mode
    #   @return [String] The mode used to capture the card details at the point of sale.
    # @!attribute pin
    #   @return [Hash] The encrypted PIN block details (`key_set_id`, `block`, `block_format`).
    # @!attribute store_for_future_use
    #   @return [TrueClass, FalseClass] Set to `true` if you intend to reuse the payment credentials
    #     in subsequent payments.
    # @!attribute name
    #   @return [String] The cardholder name.
    class CardPresentPaymentMethod
      attr_accessor :status,
                    :flags,
                    :track2,
                    :emv,
                    :entry_mode,
                    :pin,
                    :store_for_future_use,
                    :name
    end
  end
end
