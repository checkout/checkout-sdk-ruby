# frozen_string_literal: true

module CheckoutSdk
  class AbstractCheckoutSdkBuilder
    # @!attribute environment
    #   @return [Environment]
    # @!attribute http_client
    #   @return [Faraday::Connection]
    # @!attribute multipart_http_client
    #   @return [Faraday::Connection]
    # @!attribute subdomain
    #   @return [String, nil]
    attr_accessor :environment, :http_client, :multipart_http_client, :logger, :subdomain

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
      @subdomain = subdomain
      self
    end

    # Opts out of the merchant-specific subdomain, sending every request to the shared hosts
    # instead (api.checkout.com and access.checkout.com, or their sandbox equivalents).
    #
    # @deprecated This is an emergency fallback for the rare case where the merchant-specific
    #   subdomain cannot be used, and will be removed in a future release. Call
    #   {#with_environment_subdomain} instead.
    #   See https://api-reference.checkout.com/#section/Base-URLs
    def with_legacy_domain
      warn '[DEPRECATION] with_legacy_domain is deprecated and will be removed in a future ' \
           'release. It is intended only as an emergency fallback when the merchant-specific ' \
           'subdomain cannot be used. Call with_environment_subdomain instead. ' \
           'See https://api-reference.checkout.com/#section/Base-URLs'
      @use_legacy_domain = true
      self
    end

    # @return [EnvironmentSubdomain, nil]
    def environment_subdomain
      return nil if subdomain.nil?

      EnvironmentSubdomain.new(environment, subdomain)
    end

    # Whether this builder requires the merchant-specific subdomain to be configured. The
    # Previous (ABC) platform predates merchant-specific subdomains, so it overrides this.
    def requires_environment_subdomain?
      true
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
      validate_environment_settings
    end

    private

    def validate_environment_settings
      if !subdomain.nil? && @use_legacy_domain
        raise CheckoutArgumentException,
              'with_environment_subdomain and with_legacy_domain cannot both be set - provide ' \
              'only your merchant-specific subdomain'
      end
      return unless subdomain.nil? && !@use_legacy_domain && requires_environment_subdomain?

      raise CheckoutArgumentException,
            'environment subdomain is required - provide your merchant-specific subdomain (the ' \
            'first 8 characters of your client ID, see ' \
            'https://api-reference.checkout.com/#section/Base-URLs), or call with_legacy_domain ' \
            'to opt out only if merchant specific sub domains are causing issues'
    end
  end
end
