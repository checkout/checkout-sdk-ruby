# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute country
    #   @return [CheckoutSdk::Common::Country]
    # @!attribute account_number
    #   @return [String]
    # @!attribute bank_code
    #   @return [String]
    # @!attribute currency
    #   @return [CheckoutSdk::Common::Currency]
    # @!attribute mandate_id
    #   @return [String]
    # @!attribute date_of_signature
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class SepaSource < PaymentSource
      attr_accessor :country,
                    :account_number,
                    :bank_code,
                    :currency,
                    :mandate_id,
                    :date_of_signature,
                    :account_holder

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::SEPA)
      end
    end
  end
end
