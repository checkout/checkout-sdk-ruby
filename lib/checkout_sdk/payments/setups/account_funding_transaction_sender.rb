# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute first_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute date_of_birth
    #   @return [String] Format: YYYY-MM-DD
    # @!attribute country_of_birth
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute nationality
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute identification
    #   @return [AccountFundingTransactionIdentification]
    class AccountFundingTransactionSender
      attr_accessor :first_name,
                    :last_name,
                    :date_of_birth,
                    :country_of_birth,
                    :nationality,
                    :address,
                    :identification
    end
  end
end
