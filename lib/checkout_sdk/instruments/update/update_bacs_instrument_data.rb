# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The details of a Bacs Direct Debit account being updated.
    #
    # Every property is optional on this shape.
    #
    # @!attribute account_number
    #   @return [String] The account number of the Bacs Direct Debit account.
    #     [Optional] min 8 characters, max 8 characters.
    # @!attribute bank_code
    #   @return [String] The sort code of the Bacs Direct Debit account.
    #     [Optional] min 6 characters, max 6 characters.
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} The country of the account,
    #     as an ISO 3166-1 alpha-2 code. [Optional] min 2 characters, max 2 characters.
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency} The currency of the account.
    #     [Optional] min 3 characters, max 3 characters.
    # @!attribute payment_type
    #   @return [String] {BacsPaymentType} The type of payment, Recurring or
    #     Regular. [Optional] Capitalized, unlike the SEPA equivalent.
    # @!attribute allow_partial_match
    #   @return [TrueClass, FalseClass] Whether vault accepted a partial match when
    #     looking up the Bacs instrument for the supplied account details. [Optional]
    class UpdateBacsInstrumentData
      attr_accessor :account_number,
                    :bank_code,
                    :country,
                    :currency,
                    :payment_type,
                    :allow_partial_match
    end
  end
end
