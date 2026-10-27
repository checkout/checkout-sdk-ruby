# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute first_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute account_number
    #   @return [String]
    # @!attribute account_type
    #   @deprecated Not part of the Recipient schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [String]
    # @!attribute date_of_birth
    #   @return [String] Format: YYYY-MM-DD
    # @!attribute address
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
