# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Card Present payment method configuration on a Payment Setup, sent under the
    # `payment_methods.card_present` key.
    #
    # @deprecated card_present is no longer part of the Payment Setups API specification. There is no
    #   replacement. Will be removed in the next major version.
    #
    # @!attribute status
    #   @deprecated card_present is no longer part of the Payment Setups API specification. There is no
    #     replacement. Will be removed in the next major version.
    #   @return [String] (response-only) Payment method status, one of
    #     {PaymentSetupPaymentMethodStatus} (e.g. "ready").
    # @!attribute flags
    #   @deprecated card_present is no longer part of the Payment Setups API specification. There is no
    #     replacement. Will be removed in the next major version.
    #   @return [Array(String)] (response-only) Diagnostic flags returned by the API.
    # @!attribute track2
    #   @deprecated card_present is no longer part of the Payment Setups API specification. There is no
    #     replacement. Will be removed in the next major version.
    #   @return [String] The Track 2 data read from card or device.
    # @!attribute emv
    #   @deprecated card_present is no longer part of the Payment Setups API specification. There is no
    #     replacement. Will be removed in the next major version.
    #   @return [String] The EMV data read from the card or device.
    # @!attribute entry_mode
    #   @deprecated card_present is no longer part of the Payment Setups API specification. There is no
    #     replacement. Will be removed in the next major version.
    #   @return [String] The mode used to capture the card details at the point of sale.
    # @!attribute pin
    #   @deprecated card_present is no longer part of the Payment Setups API specification. There is no
    #     replacement. Will be removed in the next major version.
    #   @return [Hash] The encrypted PIN block details (`key_set_id`, `block`, `block_format`).
    # @!attribute store_for_future_use
    #   @deprecated card_present is no longer part of the Payment Setups API specification. There is no
    #     replacement. Will be removed in the next major version.
    #   @return [TrueClass, FalseClass] Set to `true` if you intend to reuse the payment credentials
    #     in subsequent payments.
    # @!attribute name
    #   @deprecated card_present is no longer part of the Payment Setups API specification. There is no
    #     replacement. Will be removed in the next major version.
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
