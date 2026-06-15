# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for PATCH /issuing/cards/{cardId}.
    #
    # @!attribute reference
    #   @return [String]
    # @!attribute metadata
    #   @return [Hash{String => String}]
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    class UpdateCardRequest
      attr_accessor :reference, :metadata, :expiry_month, :expiry_year
    end
  end
end
