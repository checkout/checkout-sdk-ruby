# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [String] {CheckoutSdk::Common::InstrumentType}
    # @!attribute label
    #   @return [String]
    # @!attribute account_type
    #   @return [String] {CheckoutSdk::Common::AccountType}
    # @!attribute account_number
    #   @return [String]
    # @!attribute bank_code
    #   @return [String]
    # @!attribute branch_code
    #   @return [String]
    # @!attribute iban
    #   @return [String]
    # @!attribute bban
    #   @return [String]
    # @!attribute swift_bic
    #   @return [String]
    # @!attribute currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute document
    #   @return [InstrumentDocument]
    # @!attribute bank
    #   @return [BankDetails]
    # @!attribute account_holder
    #   @return [AccountHolder]
    class PaymentInstrument
      attr_accessor :type,
                    :label,
                    :account_type,
                    :account_number,
                    :bank_code,
                    :branch_code,
                    :iban,
                    :bban,
                    :swift_bic,
                    :currency,
                    :country,
                    :document,
                    :bank,
                    :account_holder
    end
  end
end
