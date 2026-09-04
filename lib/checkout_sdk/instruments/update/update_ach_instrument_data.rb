# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The details of the bank account of an ACH instrument being updated.
    #
    # Every property is optional on this shape.
    #
    # @!attribute account_type
    #   @return [String] {AchAccountType} The type of Direct Debit account,
    #     savings or checking. [Optional]
    # @!attribute account_number
    #   @return [String] The account number of the Direct Debit account.
    #     [Optional] min 4 characters, max 17 characters.
    # @!attribute bank_code
    #   @return [String] The bank code of the Direct Debit account.
    #     [Optional] min 8 characters, max 9 characters.
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency} The currency of the account.
    #     [Optional] min 3 characters, max 3 characters.
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} The country of the account.
    #     [Optional] min 2 characters, max 2 characters.
    class UpdateAchInstrumentData
      attr_accessor :account_type,
                    :account_number,
                    :bank_code,
                    :currency,
                    :country
    end
  end
end
