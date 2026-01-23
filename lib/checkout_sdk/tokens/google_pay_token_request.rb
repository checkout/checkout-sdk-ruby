# frozen_string_literal: true

module CheckoutSdk
  module Tokens
    # @!attribute token_data
    #   @return [GooglePayTokenData]
    class GooglePayTokenRequest < WalletTokenRequest
      attr_accessor :token_data

      def initialize
        super(CheckoutSdk::Tokens::TokenType::GOOGLE_PAY)
      end
    end
  end
end
