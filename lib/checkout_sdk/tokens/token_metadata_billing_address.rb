# frozen_string_literal: true

module CheckoutSdk
  module Tokens
    # Partial billing address (city + country) returned by GET /tokens/{tokenId}/metadata.
    #
    # @!attribute city
    #   @return [String]
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country}
    class TokenMetadataBillingAddress
      attr_accessor :city,
                    :country
    end
  end
end
