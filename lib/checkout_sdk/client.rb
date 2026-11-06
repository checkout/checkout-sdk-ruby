# frozen_string_literal: true

module CheckoutSdk
  # @!attribute api_client
  #   @return [ApiClient]
  # @!attribute authorization_type
  #   @return [CheckoutConfiguration]
  # @!attribute configuration
  #   @return [String] {AuthorizationType}
  class Client
    attr_reader :api_client,
                :authorization_type,
                :configuration

    protected

    # @param [CheckoutSdk::ApiClient] api_client
    # @param [CheckoutConfiguration] configuration
    # @param [String] authorization_type {AuthorizationType}
    def initialize(api_client, configuration, authorization_type)
      @api_client = api_client
      @authorization_type = authorization_type
      @configuration = configuration
    end

    # Joins the arguments into a request path. Each argument is one path segment and is
    # percent-encoded, so it never adds segments, a query or a fragment.
    #
    # @param [Array<String, Symbol, Integer>] args
    # @return [String]
    # @raise [CheckoutArgumentException] when an argument is not a valid path segment (see
    #   CheckoutUtils.encode_path_segment)
    def build_path(*args)
      args.map { |segment| CheckoutUtils.encode_path_segment(segment) }.join('/')
    end

    # @return [TrueClass, FalseClass]
    def sandbox?
      @configuration.environment.is_sandbox
    end

    # @param [String, nil] authorization_type {AuthorizationType}
    def sdk_authorization(authorization_type = nil)
      if authorization_type.nil?
        configuration.credentials.get_authorization(@authorization_type)
      else
        configuration.credentials.get_authorization(authorization_type)
      end
    end
  end
end
