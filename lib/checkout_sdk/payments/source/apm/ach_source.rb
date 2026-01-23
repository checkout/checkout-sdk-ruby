# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute account_type
    #   @return [CheckoutSdk::Common::AccountType]
    # @!attribute country
    #   @return [CheckoutSdk::Common::Country]
    # @!attribute account_number
    #   @return [String]
    # @!attribute bank_code
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
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
