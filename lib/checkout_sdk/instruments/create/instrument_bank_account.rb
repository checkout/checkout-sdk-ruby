# frozen_string_literal: true

module CheckoutSdk
  module Instruments
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
    # @!attribute processing_channel_id
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    # @!attribute bank
    #   @return [CheckoutSdk::Common::BankDetails]
    # @!attribute customer
    #   @return [CheckoutSdk::Common::CustomerRequest]
    class InstrumentBankAccount < Instrument
      attr_accessor :account_type,
                    :account_number,
                    :bank_code,
                    :branch_code,
                    :iban,
                    :bban,
                    :swift_bic,
                    :currency,
                    :country,
                    :processing_channel_id,
                    :account_holder,
                    :bank,
                    :customer

      def initialize
        super(CheckoutSdk::Common::InstrumentType::BANK_ACCOUNT)
      end
    end
  end
end
