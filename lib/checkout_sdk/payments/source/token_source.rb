# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute token
    #   @return [String]
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute phone
    #   @return [CheckoutSdk::Common::Phone]
    # @!attribute stored
    #   @return [TrueClass, FalseClass]
    # @!attribute store_for_future_use
    #   @return [TrueClass, FalseClass]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class TokenSource < PaymentSource
      attr_accessor :token,
                    :billing_address,
                    :phone,
                    :stored,
                    :store_for_future_use,
                    :account_holder

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::TOKEN
      end
    end
  end
end
