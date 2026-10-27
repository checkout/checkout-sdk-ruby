# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Account funding transaction recipient details on a Payment Setup.
    # Maps swagger `PaymentSetup.account_funding_transaction.recipient`.
    #
    # @!attribute first_name
    #   The recipient's first name.
    #   [Optional]
    #   max 50 characters
    #   @return [String]
    # @!attribute last_name
    #   The recipient's last name.
    #   [Optional]
    #   max 50 characters
    #   @return [String]
    # @!attribute account_number
    #   Any identifier like part of the PAN (first six digits and last four digits), an IBAN, an internal
    #   account number, or a phone number related to the primary recipient's account.
    #   [Optional]
    #   max 34 characters
    #   @return [String]
    # @!attribute account_type
    #   @deprecated Not part of the Recipient schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   The type of the recipient's account.
    #   [Optional]
    #   @return [String]
    # @!attribute date_of_birth
    #   Date of birth of the recipient (yyyy-mm-dd).
    #   [Optional]
    #   Format: date
    #   @return [String]
    # @!attribute address
    #   The recipient's address. Maps swagger `PaymentSetupAddress`; all keys are optional:
    #   - `address_line1`: The first line of the address. max 200 characters
    #   - `address_line2`: The second line of the address. max 200 characters
    #   - `city`: The address city. max 50 characters
    #   - `state`: The address state or county. max 50 characters
    #   - `zip`: The postal or zip code. max 50 characters
    #   - `country`: The address country, in ISO 3166-1 alpha-2 format. max 2 characters
    #   [Optional]
    #   @return [CheckoutSdk::Common::Address]
    class AccountFundingTransactionRecipient
      attr_accessor :first_name,
                    :last_name,
                    :account_number,
                    :account_type,
                    :date_of_birth,
                    :address
    end
  end
end
