# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The details of a Bacs Direct Debit account being stored.
    #
    # @!attribute account_number
    #   @return [String] The account number of the Bacs Direct Debit account.
    #     [Required] min 8 characters, max 8 characters.
    # @!attribute bank_code
    #   @return [String] The sort code of the Bacs Direct Debit account.
    #     [Required] min 6 characters, max 6 characters.
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} The country of the account,
    #     as an ISO 3166-1 alpha-2 code. [Required] min 2 characters, max 2 characters.
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency} The currency of the account.
    #     [Required] min 3 characters, max 3 characters.
    # @!attribute payment_type
    #   @return [String] {BacsPaymentType} The type of payment, Recurring or
    #     Regular. [Required] Capitalized, unlike the SEPA equivalent.
    # @!attribute allow_partial_match
    #   @return [TrueClass, FalseClass] Indicates whether the Bacs instrument is
    #     created when account validation returns a partial match. When true the
    #     instrument is created on a partial match; when false instrument creation
    #     fails on a partial match. [Optional] Default: false
    class CreateBacsInstrumentData
      attr_accessor :account_number,
                    :bank_code,
                    :country,
                    :currency,
                    :payment_type,
                    :allow_partial_match
    end
  end
end
