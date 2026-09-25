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
    #   @return [String] Date for the card to be automatically revoked, in the form `yyyy-mm-dd`.
    #     Must be after the current date. Maps swagger `IssuingRevocationDate`.
    #   @deprecated Use {#scheduled_revocation_date} instead.
    # @!attribute scheduled_revocation_date
    #   @return [String] Date for the card to be automatically revoked, in the form `yyyy-mm-dd`.
    #     Overrides the deprecated {#revocation_date} when both are given. Maps swagger
    #     `IssuingScheduledRevocationDate`.
    # @!attribute status
    #   @return [String] Set to `active` to reactivate an `inactive` or `suspended` card.
    #     Mutually exclusive with `scheduled_activation_date`: submitting both returns a
    #     `scheduled_activation_date_conflicts_with_activation` error. The only supported
    #     value is `active`.
    class UpdateCardRequest
      attr_accessor :reference, :metadata, :expiry_month, :expiry_year,
                    :scheduled_activation_date, :revocation_date, :scheduled_revocation_date, :status
    end
  end
end
