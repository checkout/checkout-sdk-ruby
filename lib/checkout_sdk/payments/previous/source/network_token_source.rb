# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute token
      #   @return [String]
      # @!attribute expiry_month
      #   @return [Integer]
      # @!attribute expiry_year
      #   @return [Integer]
      # @!attribute token_type
      #   @return [String] {CheckoutSdk::Payments::NetworkTokenType}
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
                      :phone

        def initialize
          super CheckoutSdk::Common::PaymentSourceType::NETWORK_TOKEN
        end
      end
    end
  end
end
