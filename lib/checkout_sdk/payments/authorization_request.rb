# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute amount
    #   @return [Integer]
    # @!attribute reference
    #   @return [String]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    class AuthorizationRequest
      attr_accessor :amount,
                    :reference,
                    :metadata
    end
  end
end
