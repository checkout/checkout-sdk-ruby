# frozen_string_literal: true

module CheckoutSdk
  # @!attribute environment
  #   @return [Environment]
  # @!attribute subdomain
  #   @return [String]
  class EnvironmentSubdomain
    attr_reader :base_uri, :environment, :subdomain

    # Initializes the EnvironmentSubdomain with the given environment and subdomain.
    #
    # @param environment [Environment] The environment object which should have a base_uri method.
    # @param subdomain [String] The subdomain to add to the environment's API URL.
    def initialize(environment, subdomain)
      @environment = environment
      @subdomain = subdomain
      @base_uri = add_subdomain_to_api_url_environment(environment, subdomain)
    end

    private

    # Adds the subdomain to the API URL of the given environment.
    #
    # @param environment [Environment] The environment object which should have a base_uri method.
    # @param subdomain [String] The subdomain to add to the environment's API URL.
    # @return [String] The new environment URL with the subdomain added.
    def add_subdomain_to_api_url_environment(environment, subdomain)
      api_url = environment.base_uri
      new_environment = api_url

      if subdomain =~ /^[0-9a-z]+$/
        url_parts = URI.parse(api_url)
        new_host = "#{subdomain}.#{url_parts.host}"

        port = url_parts.scheme == 'https' && url_parts.port == 443 ? nil : url_parts.port

        new_url_parts = URI::Generic.build(
          scheme: url_parts.scheme,
          userinfo: url_parts.userinfo,
          host: new_host,
          port: port,
          path: url_parts.path,
          query: url_parts.query,
          fragment: url_parts.fragment
        )

        new_environment = new_url_parts.to_s
      end

      new_environment
    end
  end
end
