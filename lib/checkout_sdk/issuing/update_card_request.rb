# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for PATCH /issuing/cards/{cardId}.
    #
    # @!attribute reference
    #   @return [String]
    # @!attribute metadata
    #   @return [Hash{String => String}]
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    # @!attribute activation_date
    #   @return [String] ISO-8601 date scheduling the card's activation. Supported formats:
    #     date only `yyyy-mm-dd` (treated as midnight UTC) or date with round hour
    #     `yyyy-mm-ddTHH:mmZ` / `yyyy-mm-ddTHH:mm±HH:mm`. Maps swagger `IssuingActivationDate`.
    # @!attribute revocation_date
    #   @return [String] Date for the card to be automatically revoked, in the form `yyyy-mm-dd`.
    #     Must be after the current date. Maps swagger `IssuingRevocationDate`.
    class UpdateCardRequest
      attr_accessor :reference, :metadata, :expiry_month, :expiry_year,
                    :activation_date, :revocation_date
    end
  end
end
