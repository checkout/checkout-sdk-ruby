# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # An ach payment source.
    #
    # @!attribute account_type
    #   @return [String] {AchSourceAccountType} The type of Direct Debit account.
    #     [Required] savings, checking or cash. Note this is **not**
    #     {CheckoutSdk::Common::AccountType}, which declares `current` instead of
    #     `checking` and is rejected at this position.
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country} The source country.
    #     [Required] min 2 characters, max 2 characters.
    # @!attribute account_number
    #   @return [String] The account number of the Direct Debit account.
    #     [Required] min 4 characters, max 17 characters.
    # @!attribute bank_code
    #   @return [String] The bank code of the Direct Debit account.
    #     [Required] min 8 characters, max 9 characters.
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder] The account holder's details.
    #     [Required] Maps swagger `AccountHolderAch`, which declares only
    #     first_name, last_name, company_name, type, date_of_birth, billing_address
    #     and identification - a subset of this shared type. `type` there is
    #     individual, corporate or government.
    class AchSource < PaymentSource
      attr_accessor :account_type,
                    :country,
                    :account_number,
                    :bank_code,
                    :account_holder

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::ACH)
      end
    end
  end
end
