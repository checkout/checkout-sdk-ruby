# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Information related to the processing of a card payout.
    #
    # @!attribute affiliate_id
    #   The unique identifier for Visa-registered ramp providers.
    #   Must only contain alphanumeric characters.
    #   If you're a Visa-registered ramp provider operating with affiliates, this field is required.
    #   [Optional]
    #   ^[a-zA-Z0-9]{1,15}$
    #   max 15 characters
    #   @return [String]
    # @!attribute affiliate_url
    #   The affiliate URL.
    #   If you're a Visa-registered ramp provider operating with affiliates, this field is required.
    #   [Optional]
    #   @return [String]
    # @!attribute processing_speed
    #   The speed at which the payout is processed.
    #   Only applicable for unreferenced refunds.
    #   [Optional]
    #   Enum: "fast"
    #   @return [String]
    # @!attribute purchase_country
    #   The two-letter ISO country code of the purchase country.
    #   If you're a Visa-registered ramp provider operating with affiliates, this field is required.
    #   [Optional]
    #   max 2 characters
    #   @return [String] {CheckoutSdk::Common::Country}
    class CardPayoutProcessing
      attr_accessor :affiliate_id,
                    :affiliate_url,
                    :processing_speed,
                    :purchase_country
    end
  end
end
