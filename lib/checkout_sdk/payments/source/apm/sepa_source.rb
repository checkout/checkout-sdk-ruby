# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # SEPA Direct Debit source.
    #
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} The account's country, as an
    #     ISO 3166-1 alpha-2 code. [Required]
    # @!attribute account_number
    #   @return [String] The account holder's IBAN. [Required]
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency} The account holder's account
    #     currency. [Required]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder] The account holder's personal
    #     information. [Required] Its billing_address is required, and that address
    #     requires all five of address_line1, address_line2, city, zip and country.
    #     Send account_holder.type lowercase (individual / corporate): the
    #     specification declares it capitalized at this one position, but every other
    #     account-holder-type position declares it lowercase and every other
    #     Checkout.com SDK sends lowercase. Pending confirmation from the API owners.
    # @!attribute mandate_id
    #   @return [String] The ID of the mandate. [Optional]
    # @!attribute mandate_type
    #   @return [String] {CheckoutSdk::Instruments::SepaMandateType} The type of
    #     mandate, Core or B2B. [Optional]
    # @!attribute date_of_signature
    #   @return [String] The date the mandate was signed, in the format yyyy-MM-dd.
    #     [Optional]
    # @!attribute bank_code
    #   @return [String] Not declared by PaymentRequestSEPAV4Source. No SEPA schema
    #     in the specification declares a bank code, and the SEPA source is
    #     identified by IBAN through account_number. Retained for
    #     retro-compatibility purposes only. Possibly an obsoleted field.
    class SepaSource < PaymentSource
      attr_accessor :country,
                    :account_number,
                    :currency,
                    :account_holder,
                    :mandate_id,
                    :mandate_type,
                    :date_of_signature,
                    :bank_code

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::SEPA)
      end
    end
  end
end
