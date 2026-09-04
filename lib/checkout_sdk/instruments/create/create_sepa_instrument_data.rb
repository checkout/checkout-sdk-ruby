# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The details of the mandate of a SEPA instrument being stored.
    #
    # @!attribute account_number
    #   @return [String] The International Bank Account Number (IBAN) of the
    #     account. [Required] min 15 characters, max 34 characters.
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} The country of the account.
    #     [Required] min 2 characters, max 2 characters.
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency} The currency of the account.
    #     [Required] min 3 characters, max 3 characters.
    # @!attribute payment_type
    #   @return [String] {SepaPaymentType} The type of payment, recurring or
    #     regular. [Required] Lowercase, unlike the Bacs equivalent.
    # @!attribute type
    #   @return [String] {SepaMandateType} The type of mandate, Core or B2B.
    #     [Optional]
    # @!attribute mandate_id
    #   @return [String] The mandate ID. If a mandate ID is not provided, a new,
    #     random mandate ID will be generated. [Optional] min 1 character,
    #     max 35 characters.
    # @!attribute date_of_signature
    #   @return [String] The date on which the mandate was signed, in the format
    #     yyyy-MM-dd. Required if mandate_id is provided. [Optional]
    #     Format: date - pass a yyyy-MM-dd String, not a DateTime.
    class CreateSepaInstrumentData
      attr_accessor :account_number,
                    :country,
                    :currency,
                    :payment_type,
                    :type,
                    :mandate_id,
                    :date_of_signature
    end
  end
end
