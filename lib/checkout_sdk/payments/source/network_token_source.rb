# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute token
    #   @return [String]
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    # @!attribute token_type
    #   @return [String] {NetworkTokenType}
    # @!attribute cryptogram
    #   @return [String]
    # @!attribute eci
    #   @return [String]
    # @!attribute stored
    #   @return [TrueClass, FalseClass]
    # @!attribute name
    #   @return [String]
    # @!attribute cvv
    #   @return [String]
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute phone
    #   @return [CheckoutSdk::Common::Phone]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class NetworkTokenSource < PaymentSource
      attr_accessor :token,
                    :expiry_month,
                    :expiry_year,
                    :token_type,
                    :cryptogram,
                    :eci,
                    :stored,
                    :name,
                    :cvv,
                    :billing_address,
                    :phone,
                    :account_holder

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::NETWORK_TOKEN
      end
    end
  end
end
