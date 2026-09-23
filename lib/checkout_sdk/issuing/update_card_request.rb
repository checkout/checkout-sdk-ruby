# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for PATCH /issuing/cards/{cardId}.
    #
    # @!attribute reference
    #   Your reference.
    #   [Optional]
    #   max 256 characters
    #   Example: X-123456-N11
    #   @return [String]
    # @!attribute metadata
    #   The user's metadata.
    #   [Optional]
    #   @return [Hash{String => String}]
    # @!attribute expiry_month
    #   The card's expiration month.
    #   [Optional]
    #   min 1, max 12
    #   Example: 5
    #   @return [Integer]
    # @!attribute expiry_year
    #   The card's expiration year.
    #   [Optional]
    #   min 4 characters, max 4 characters
    #   Example: 2025
    #   @return [Integer]
    # @!attribute scheduled_activation_date
    #   Date scheduling the card's first activation. Only applies to the initial activation of a
    #   card. Two formats are supported: date only (yyyy-MM-dd, treated as midnight UTC), or date
    #   with round hour (yyyy-MM-ddTHH:mmZ in UTC, or yyyy-MM-ddTHH:mm+HH:mm with offset). Only
    #   round hours are allowed when a time is provided (HH:00). The value must be at least the
    #   next round hour after the request time.
    #
    #   Renamed from activation_date by the 2026-09-02 spec, which also removed the
    #   IssuingActivationDate schema this attribute used to cite.
    #   [Optional]
    #   Example: 2026-06-01T10:00Z
    #   @return [String]
    # @!attribute revocation_date
    #   Date scheduling the card's automatic revocation.
    #   [Optional]
    #   Format: yyyy-MM-dd (time is midnight UTC)
    #   Example: 2027-03-12
    #   @return [String]
    class UpdateCardRequest
      attr_accessor :reference, :metadata, :expiry_month, :expiry_year,
                    :scheduled_activation_date, :revocation_date
    end
  end
end
