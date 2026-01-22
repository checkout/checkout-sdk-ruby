# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute id
    #   @return [String]
    # @!attribute cvv
    #   @return [String]
    # @!attribute payment_method
    #   @return [String]
    # @!attribute stored
    #   @return [TrueClass, FalseClass]
    # @!attribute store_for_future_use
    #   @return [TrueClass, FalseClass]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class IdSource < PaymentSource
      attr_accessor :id,
                    :cvv,
                    :payment_method,
                    :stored,
                    :store_for_future_use,
                    :account_holder

      def initialize
        super(CheckoutSdk::Common::PaymentSourceType::ID)
      end
    end
  end
end
