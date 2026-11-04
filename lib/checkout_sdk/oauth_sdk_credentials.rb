# frozen_string_literal: true

module CheckoutSdk
  # @!attribute access_token
  #   @return [CheckoutSdk::OAuthAccessToken]
  # @!attribute client_id
  #   @return [String]
  # @!attribute client_secret
  #   @return [String]
  # @!attribute scopes
  #   @return [Array(CheckoutSdk::OAuthScopes)]
  # @!attribute http_client
  #   @return [Object]
  # @!attribute environment
  #   @return [CheckoutSdk::Environment]
  # @!attribute authorization_uri
  #   @return [String]
  class OAuthSdkCredentials < SdkCredentials
    attr_accessor :access_token,
                  :client_id,
                  :client_secret,
                  :scopes,
                  :http_client,
                  :environment,
                  :authorization_uri,
                  :log

    # @param [String] client_id
    # @param [String] client_secret
    # @param [Array(CheckoutSdk::OAuthScopes)] scopes
    # @param [Faraday::Connection] http_client
    # @param [CheckoutSdk::Environment] environment
    # @param [String, nil] auth_uri
    def initialize(client_id, client_secret, scopes, http_client, environment, logger, auth_uri = nil)
      validate_arguments client_id, client_secret, environment, auth_uri
      @client_id = client_id
      @client_secret = client_secret
      @scopes = scopes
      @authorization_uri = auth_uri.nil? ? environment.authorization_uri : auth_uri
      @oauth_http_client = http_client.clone
      @oauth_http_client.url_prefix = @authorization_uri
      @log = logger
      build_access_token
    end

    # @param [String] authorization_type
    # @return [CheckoutSdk::SdkAuthorization]
    def get_authorization(authorization_type)
      case authorization_type
      when AuthorizationType::SECRET_KEY_OR_OAUTH, AuthorizationType::PUBLIC_KEY_OR_OAUTH, AuthorizationType::OAUTH
        SdkAuthorization.new(PlatformType::DEFAULT, build_access_token.token)
      else
        raise CheckoutAuthorizationException.invalid_authorization authorization_type
      end
    end

    # @return [CheckoutSdk::OAuthAccessToken]
    def build_access_token
      return @access_token unless @access_token.nil? || @access_token.token.nil? || !@access_token.valid?

      data = {
        grant_type: 'client_credentials',
        client_id: @client_id,
        client_secret: @client_secret,
        scope: @scopes.join(' ')
      }

      response = request_access_token(URI.encode_www_form(data))

      if !response.body.nil? && response.body != ''
        oauth_response = JSON.parse(response.body, object_class: OpenStruct)

        @access_token = OAuthAccessToken.new(oauth_response.access_token,
                                             oauth_response.token_type,
                                             Time.now + oauth_response.expires_in)
      end

      @access_token
    end

    private

    # @param [String] body
    # @return [Faraday::Response]
    def request_access_token(body)
      headers = { 'Content-Type': 'application/x-www-form-urlencoded' }
      @log.info "post: #{CheckoutUtils.loggable_path(authorization_uri)}"
      @oauth_http_client.run_request(:post, @authorization_uri, body, headers)
    rescue Faraday::ClientError => e
      raise CheckoutAuthorizationException.token_request_failed(CheckoutUtils.map_to_http_metadata(e.response)),
            cause: nil
    rescue Faraday::ConnectionFailed => e
      raise CheckoutArgumentException, e.wrapped_exception
    rescue Faraday::Error => e
      raise CheckoutUtils.without_request_data(e), cause: nil
    end

    # @param [String] client_id
    # @param [String] client_secret
    # @param [Environment] environment
    # @param [String, nil] authorization_uri
    def validate_arguments(client_id, client_secret, environment, authorization_uri)
      if client_id.nil? || client_secret.nil?
        raise CheckoutArgumentException, 'Invalid OAuth "client_id" or "client_secret"'
      end

      return unless environment.nil? && authorization_uri.nil?

      raise CheckoutArgumentException,
            'Invalid configuration. Please specify an "environment" or a specific OAuth "authorization_uri"'
    end
  end
end
