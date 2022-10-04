# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute payment_method
    #   @return [String]
    # @!attribute account_type
    #   @return [String] {CheckoutSdk::Common::AccountType}
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute account_number
    #   @return [String]
    # @!attribute bank_code
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class BankAccountSource < PaymentSource
      attr_accessor :payment_method,
                    :account_type,
                    :country,
                    :account_number,
                    :bank_code,
                    :account_holder

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::BANK_ACCOUNT
      end
    end
  end
end
