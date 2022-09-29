# frozen_string_literal: true

module CheckoutSdk
  module Tokens
    # @!attribute type
    #   @return [String]
    # @!attribute number
    #   @return [String]
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    # @!attribute name
    #   @return [String]
    # @!attribute cvv
    #   @return [String]
    # @!attribute billing_address
    #   @return [String] {CheckoutSdk::Common::Address}
    # @!attribute phone
    #   @return [String] {CheckoutSdk::Common::Phone}
    class CardTokenRequest
      attr_accessor :type,
                    :number,
                    :expiry_month,
                    :expiry_year,
                    :name,
                    :cvv,
                    :billing_address,
                    :phone

      def initialize
        @type = CheckoutSdk::Tokens::TokenType::CARD
      end
    end
  end
end
