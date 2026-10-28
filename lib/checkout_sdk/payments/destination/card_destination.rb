# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A card payout destination.
    #
    # @!attribute number
    #   The card number.
    #   You can encrypt this field by using the Cko-Encryption-Key-Id and Cko-Encrypted-Properties headers.
    #   [Required]
    #   max 19 characters
    #   @return [String]
    # @!attribute expiry_month
    #   The card's expiration month.
    #   [Required]
    #   1 to 2 digits
    #   @return [Integer]
    # @!attribute expiry_year
    #   The card's expiration year.
    #   [Required]
    #   4 digits
    #   @return [Integer]
    # @!attribute account_holder
    #   The payout destination account holder.
    #   [Required]
    #   The type discriminates the accepted keys:
    #   - individual: type, first_name, middle_name, last_name, billing_address, phone,
    #     identification, email, date_of_birth, country_of_birth
    #   - corporate, government: type, company_name, billing_address, phone, identification, email
    #   Other AccountHolder properties (full_name, gender, tax_id, residential_status,
    #   account_name_inquiry) are not part of this position.
    #   @return [CheckoutSdk::Common::AccountHolder]
    class CardDestination < Destination
      attr_accessor :number,
                    :expiry_month,
                    :expiry_year,
                    :account_holder

      def initialize
        super(CheckoutSdk::Payments::DestinationType::CARD)
      end
    end
  end
end
