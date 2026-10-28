# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A network token payout destination, used as the destination of a card payout or of an
    # unreferenced refund.
    #
    # @!attribute token
    #   The network token's Primary Account Number (PAN).
    #   [Required]
    #   @return [String]
    # @!attribute expiry_month
    #   The network token's expiration month.
    #   [Required]
    #   min 1
    #   1 to 2 digits
    #   @return [Integer]
    # @!attribute expiry_year
    #   The network token's expiration year.
    #   [Required]
    #   4 digits
    #   @return [Integer]
    # @!attribute token_type
    #   The network token type.
    #   [Required]
    #   @return [String] {CheckoutSdk::Payments::NetworkTokenType}
    # @!attribute cryptogram
    #   The network token's Base64-encoded cryptographic identifier (TAVV).
    #   The cryptogram is used by card schemes to validate the token verification result.
    #   [Optional]
    #   max 50 characters
    #   @return [String]
    # @!attribute eci
    #   The network token's Electronic Commerce Indicator (ECI) security level.
    #   [Optional]
    #   max 2 characters
    #   @return [String]
    # @!attribute account_holder
    #   The payout or unreferenced refund destination account holder.
    #   [Required]
    #   The type discriminates the accepted keys:
    #   - individual: type, first_name, middle_name, last_name, billing_address, phone,
    #     identification, email, date_of_birth, country_of_birth
    #   - corporate, government: type, company_name, billing_address, phone, identification, email
    #   Other AccountHolder properties (full_name, gender, tax_id, residential_status,
    #   account_name_inquiry) are not part of this position.
    #   @return [CheckoutSdk::Common::AccountHolder]
    class NetworkTokenDestination < Destination
      attr_accessor :token,
                    :expiry_month,
                    :expiry_year,
                    :token_type,
                    :cryptogram,
                    :eci,
                    :account_holder

      def initialize
        super(CheckoutSdk::Payments::DestinationType::NETWORK_TOKEN)
      end
    end
  end
end
