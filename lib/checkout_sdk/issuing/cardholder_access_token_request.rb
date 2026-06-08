# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Form-encoded body for POST /issuing/access/connect/token.
    # The api_client encodes this as application/x-www-form-urlencoded.
    #
    # @!attribute grant_type
    #   @return [String] Must be "client_credentials".
    # @!attribute client_id
    #   @return [String] Access key ID.
    # @!attribute client_secret
    #   @return [String] Access key secret.
    # @!attribute cardholder_id
    #   @return [String] The cardholder's unique identifier (e.g. "crh_...").
    # @!attribute single_use
    #   @return [Boolean] Whether the request is for a single-use token.
    class CardholderAccessTokenRequest
      attr_accessor :grant_type, :client_id, :client_secret, :cardholder_id, :single_use

      def initialize
        @grant_type = 'client_credentials'
      end
    end
  end
end
