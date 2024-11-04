# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute account_type
    #   @return [AccountType]
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
    #   @return [Country]
    # @!attribute account_holder
    #   @return [AccountHolder]
    # @!attribute bank
    #   @return [BankDetails]
    class Destination
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
    end
  end
end
