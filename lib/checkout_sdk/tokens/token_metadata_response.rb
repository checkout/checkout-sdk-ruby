# frozen_string_literal: true

module CheckoutSdk
  module Tokens
    # Response from GET /tokens/{tokenId}/metadata.
    #
    # @!attribute token
    #   @return [String]
    # @!attribute type
    #   @return [String]
    # @!attribute expires_on
    #   @return [String] RFC 3339 timestamp.
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    # @!attribute scheme
    #   @return [String]
    # @!attribute last4
    #   @return [String]
    # @!attribute bin
    #   @return [String]
    # @!attribute card_type
    #   @return [String] One of CREDIT/DEBIT/PREPAID/CHARGE/"DEFERRED DEBIT".
    # @!attribute card_category
    #   @return [String] One of CONSUMER/COMMERCIAL.
    # @!attribute issuer
    #   @return [String]
    # @!attribute issuer_country
    #   @return [String] ISO 3166-1 alpha-2.
    # @!attribute product_id
    #   @return [String]
    # @!attribute product_type
    #   @return [String]
    # @!attribute billing_address
    #   @return [TokenMetadataBillingAddress]
    class TokenMetadataResponse
      attr_accessor :token,
                    :type,
                    :expires_on,
                    :expiry_month,
                    :expiry_year,
                    :scheme,
                    :last4,
                    :bin,
                    :card_type,
                    :card_category,
                    :issuer,
                    :issuer_country,
                    :product_id,
                    :product_type,
                    :billing_address
    end
  end
end
