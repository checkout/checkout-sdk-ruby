# frozen_string_literal: true

module CheckoutSdk
  # @!attribute credentials
  #   @return [SdkCredentials]
  # @!attribute environment
  #   @return [Environment]
  # @!attribute http_client
  #   @return [Faraday::Connection]
  # @!attribute multipart_http_client
  #   @return [Faraday::Connection]
  # @!attribute logger
  #   @return [Logger]
  # @!attribute environment_subdomain
  #   @return [EnvironmentSubdomain, nil]
  class CheckoutConfiguration
    attr_accessor :credentials, :environment, :http_client, :multipart_http_client, :logger, :environment_subdomain

    # Initializes the CheckoutConfiguration.
    #
    # @param [SdkCredentials] credentials
    # @param [Environment] environment
    # @param [Faraday::Connection] http_client
    # @param [Faraday::Connection] multipart_http_client
    # @param [Logger] logger
    # @param [EnvironmentSubdomain, nil] environment_subdomain (optional, default: nil)
    def initialize(credentials, environment, http_client, multipart_http_client, logger, environment_subdomain = nil)
      @credentials = credentials
      @environment = environment
      @http_client = http_client
      @multipart_http_client = multipart_http_client
      @logger = logger
      @environment_subdomain = environment_subdomain
    end
  end
end
