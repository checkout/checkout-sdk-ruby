# frozen_string_literal: true

module CheckoutSdk
  class AbstractCheckoutSdkBuilder
    # @!attribute environment
    #   @return [Environment]
    # @!attribute http_client
    #   @return [Faraday::Connection]
    # @!attribute multipart_http_client
    #   @return [Faraday::Connection]
    # @!attribute environment_subdomain
    #   @return [EnvironmentSubdomain, nil]
    attr_accessor :environment, :http_client, :multipart_http_client, :logger, :environment_subdomain

    # @param [Environment] environment
    def with_environment(environment)
      @environment = environment
      self
    end

    # @param [Faraday::Connection] http_client
    def with_http_client(http_client)
      @http_client = http_client
      self
    end

    # @param [Faraday::Connection] multipart_http_client
    def with_multipart_http_client(multipart_http_client)
      @multipart_http_client = multipart_http_client
      self
    end

    def with_logger(logger)
      @logger = logger
      self
    end

    # @param [String, nil] subdomain
    def with_environment_subdomain(subdomain)
      @environment_subdomain = EnvironmentSubdomain.new(@environment, subdomain)
      self
    end

    def build
      with_environment(Environment.sandbox) if environment.nil?
      if http_client.nil?
        @http_client = CheckoutUtils.build_default_client
      else
        unless @http_client.instance_of?(Faraday::Connection)
          raise CheckoutArgumentException, 'http_client must be an instance of Faraday::Connection'
        end
      end
      if multipart_http_client.nil?
        @multipart_http_client = CheckoutUtils.build_multipart_client
      else
        unless @multipart_http_client.instance_of?(Faraday::Connection)
          raise CheckoutArgumentException, 'multipart_http_client must be an instance of Faraday::Connection'
        end
      end
      @logger = SimpleLogger.new.logger if @logger.nil?
    end
  end
end
