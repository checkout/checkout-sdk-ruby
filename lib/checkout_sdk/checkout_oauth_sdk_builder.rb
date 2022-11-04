# frozen_string_literal: true

module CheckoutSdk
  # @!attribute client_id
  #   @return [String]
  # @!attribute client_secret
  #   @return [String]
  # @!attribute authorization_uri
  #   @return [String]
  # @!attribute scopes
  #   @return [Array(CheckoutSdk::OAuthScopes)]
  class CheckoutOAuthSdkBuilder < AbstractCheckoutSdkBuilder
    attr_accessor :client_id,
                  :client_secret,
                  :authorization_uri,
                  :scopes

    # @param [String] client_id
    # @param [String] client_secret
    # @return [CheckoutOAuthSdkBuilder]
    def with_client_credentials(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
      self
    end

    # @param [String] authorization_uri
    # @return [CheckoutOAuthSdkBuilder]
    def with_authorization_uri(authorization_uri)
      @authorization_uri = authorization_uri
      self
    end

    # @param [Array(CheckoutSdk::OAuthScopes)] scopes
    # @return [CheckoutOAuthSdkBuilder]
    def with_scopes(scopes)
      @scopes = scopes
      self
    end

    # @return [CheckoutSdk::CheckoutApi]
    def build
      super
      CheckoutSdk::CheckoutApi.new(
        CheckoutConfiguration.new(
          OAuthSdkCredentials.new(client_id, client_secret, scopes, http_client, environment, authorization_uri),
          environment,
          http_client,
          multipart_http_client
        )
      )
    end
  end
end
