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

      env_subdomain = environment_subdomain

      # Determine authorization URI following Go logic
      auth_uri = authorization_uri
      if auth_uri.nil? || auth_uri.empty?
        auth_uri = env_subdomain ? env_subdomain.authorization_uri : environment.authorization_uri
      end

      configuration = CheckoutConfiguration.new(
        OAuthSdkCredentials.new(client_id,
                                client_secret,
                                scopes,
                                http_client,
                                environment,
                                logger,
                                auth_uri),
        environment,
        http_client,
        multipart_http_client,
        logger
      )

      configuration.environment_subdomain = env_subdomain if env_subdomain

      CheckoutApi.new(configuration)
    end
  end
end
