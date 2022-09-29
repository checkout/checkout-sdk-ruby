# frozen_string_literal: true

module CheckoutSdk
  module Payments
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
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    # @!attribute bank
    #   @return [CheckoutSdk::Common::BankDetails]
    class BankAccountDestination < Destination
      attr_accessor :account_type,
                    :account_number,
                    :bank_code,
                    :branch_code,
                    :iban,
                    :bban,
                    :swift_bic,
                    :country,
                    :account_holder,
                    :bank

      def initialize
        super CheckoutSdk::Payments::DestinationType::BANK_ACCOUNT
      end
    end
  end
end
