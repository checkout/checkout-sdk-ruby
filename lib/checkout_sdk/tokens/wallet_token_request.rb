# frozen_string_literal: true

module CheckoutSdk
  module Tokens
    # @!attribute type
    #   @return [String] {TokenType}
    class WalletTokenRequest
      attr_accessor :type

      protected

      # @abstract
      # @param [String] type {TokenType}
      def initialize(type)
        @type = type
      end
    end
  end
end
