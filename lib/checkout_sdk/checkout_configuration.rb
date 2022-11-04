# frozen_string_literal: true

module CheckoutSdk
  # @!attribute credentials
  #   @return [SdkCredentials]
  # @!attribute environment
  #   @return [Environment]
  # @!attribute http_client
  #   @return [Faraday::Connection]
  class CheckoutConfiguration
    attr_accessor :credentials, :environment, :http_client, :multipart_http_client

    # @param [SdkCredentials] credentials
    # @param [Environment] environment
    # @param [Faraday::Connection] http_client
    # @param [Faraday::Connection] multipart_http_client
    def initialize(credentials, environment, http_client, multipart_http_client)
      @credentials = credentials
      @environment = environment
      @http_client = http_client
      @multipart_http_client = multipart_http_client
    end
  end
end
