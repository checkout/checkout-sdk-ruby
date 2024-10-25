# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute id
    #   @return [String]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class CustomerSource < PaymentSource
      attr_accessor :id,
                    :account_holder

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::CUSTOMER
      end
    end
  end
end
