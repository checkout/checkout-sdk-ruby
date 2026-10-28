# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A bank account payout destination (bank payout, type bank_account).
    #
    # @!attribute account_type
    #   The type of the bank account. Note that some beneficiary banks do not accept payouts to
    #   savings accounts.
    #   [Required]
    #   @return [String] {CheckoutSdk::Common::AccountType}
    # @!attribute account_number
    #   Number (which can contain letters) that identifies the local account.
    #   [Optional]
    #   @return [String]
    # @!attribute bank_code
    #   Code that identifies the bank. Also referred as Routing Number in the United States.
    #   [Optional]
    #   @return [String]
    # @!attribute branch_code
    #   Code that identifies the bank branch.
    #   [Optional]
    #   @return [String]
    # @!attribute iban
    #   Internationally agreed standard for identifying bank accounts. Lengths vary per destination_country.
    #   [Optional]
    #   @return [String]
    # @!attribute bban
    #   The combination of bank code and/or branch code and account number.
    #   [Optional]
    #   @return [String]
    # @!attribute swift_bic
    #   8 or 11 character code which identifies the bank or bank branch.
    #   [Optional]
    #   @return [String]
    # @!attribute country
    #   The two-letter ISO country code of where the account is based. Note that not all countries
    #   are available.
    #   [Required]
    #   2 characters
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute account_holder
    #   The account holder details.
    #   [Optional]
    #   @return [CheckoutSdk::Common::AccountHolder]
    # @!attribute bank
    #   The bank details.
    #   [Optional]
    #   @deprecated Not in the current specification of the bank account payout destination, so the
    #     API does not define it. Retained for backwards compatibility and will be removed in a
    #     future version.
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
        super(CheckoutSdk::Payments::DestinationType::BANK_ACCOUNT)
      end
    end
  end
end
