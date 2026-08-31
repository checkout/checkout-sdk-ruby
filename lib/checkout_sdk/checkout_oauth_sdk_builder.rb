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
      auth_uri = resolve_authorization_uri(env_subdomain)

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

    private

    # @param [EnvironmentSubdomain, nil] env_subdomain
    # @return [String]
    def resolve_authorization_uri(env_subdomain)
      auth_uri = authorization_uri
      explicit_uri_set = !(auth_uri.nil? || auth_uri.empty?)

      if explicit_uri_set && env_subdomain
        raise CheckoutArgumentException,
              'authorization_uri and environment_subdomain cannot both be set - the token ' \
              'endpoint is derived from your subdomain; combine authorization_uri with ' \
              'with_legacy_domain if you need a custom token host'
      end

      return auth_uri if explicit_uri_set

      env_subdomain ? env_subdomain.authorization_uri : environment.authorization_uri
    end
  end
end
