# frozen_string_literal: true

module CheckoutSdk
  class AbstractCheckoutSdkBuilder
    # @!attribute environment
    #   @return [Environment]
    # @!attribute http_client
    #   @return [Object]
    attr_accessor :environment, :http_client

    # @param [Environment] environment
    def with_environment(environment)
      @environment = environment
      self
    end

    def with_http_client(http_client)
      @http_client = http_client
      self
    end

    def build
      with_environment(Environment.sandbox) if environment.nil?
      raise CheckoutArgumentException, 'HttpClient must be an instance of Faraday::Connection' \
      if !http_client.nil? && !@http_client.instance_of?(Faraday::Connection)
    end
  end
end
