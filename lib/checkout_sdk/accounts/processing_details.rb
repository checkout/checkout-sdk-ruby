# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The sub-entity's expected processing (processing_details, Accounts API v3.0).
    # @!attribute settlement_country
    #   The country code (iso-3166-1 alpha-2) where the settlement bank account is located.
    #   [Required] on the EEA, GB and US Company and Sole Trader Full (3.0) variants; not part of the US ISV
    #   Seller variants.
    #   Format: iso-3166-1-alpha-2
    #   2 characters
    #   @return [String]
    # @!attribute target_countries
    #   Target country codes (iso-3166-1 alpha-2) with more than 10% expected volume processing with
    #   Checkout.com.
    #   [Required]
    #   min 1 item, max 10 items
    #   @return [Array(String)]
    # @!attribute annual_processing_volume
    #   The estimated annual processing volume. In minor units without decimals.
    #   [Required]
    #   min 0
    #   @return [Integer]
    # @!attribute average_transaction_value
    #   The expected average transaction value. In minor units without decimals.
    #   [Required]
    #   min 0
    #   @return [Integer]
    # @!attribute average_order_fulfillment_time
    #   The average time in days between accepting payment and fulfilling the order.
    #   [Required] on the US ISV Seller variants only.
    #   min 0
    #   @return [Integer]
    # @!attribute highest_transaction_value
    #   The expected highest transaction value. In minor units without decimals.
    #   [Required] on the EEA, GB and US Company and Sole Trader Full (3.0) variants; not part of the US ISV
    #   Seller variants.
    #   min 0
    #   @return [Integer]
    # @!attribute currency
    #   The currency used for the processing details provided.
    #   [Required]
    #   @return [CheckoutSdk::Common::Currency]
    # @!attribute payments
    #   Payment method-specific processing details.
    #   [Required] on the US ISV Seller variants only.
    #   @return [ProcessingDetailsPayments]
    class ProcessingDetails
      attr_accessor :settlement_country,
                    :target_countries,
                    :annual_processing_volume,
                    :average_transaction_value,
                    :average_order_fulfillment_time,
                    :highest_transaction_value,
                    :currency,
                    :payments
    end
  end
end
