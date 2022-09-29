# frozen_string_literal: true

module CheckoutSdk
  module Tokens
    # @!attribute token_data
    #   @return [ApplePayTokenData]
    class ApplePayTokenRequest < WalletTokenRequest
      attr_accessor :token_data

      def initialize
        super CheckoutSdk::Tokens::TokenType::APPLE_PAY
      end
    end
  end
end
