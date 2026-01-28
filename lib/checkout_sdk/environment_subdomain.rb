# frozen_string_literal: true

module CheckoutSdk
  # @!attribute environment
  #   @return [Environment]
  # @!attribute subdomain
  #   @return [String]
  # @!attribute authorization_uri
  #   @return [String]
  class EnvironmentSubdomain
    attr_reader :base_uri, :authorization_uri, :environment, :subdomain

    # Initializes the EnvironmentSubdomain with the given environment and subdomain.
    #
    # @param environment [Environment] The environment object which should have a base_uri method.
    # @param subdomain [String] The subdomain to add to the environment's API URL.
    def initialize(environment, subdomain)
      @environment = environment
      @subdomain = subdomain
      @base_uri = create_url_with_subdomain(environment.base_uri, subdomain)
      @authorization_uri = create_url_with_subdomain(environment.authorization_uri, subdomain)
    end

    private

    # Applies subdomain transformation to any given URI.
    # If the subdomain is valid (alphanumeric pattern), prepends it to the host.
    # Otherwise, returns the original URI unchanged.
    #
    # @param original_url [String] The original URL to transform.
    # @param subdomain [String] The subdomain to prepend to the host.
    # @return [String] The transformed URL with subdomain, or original URL if subdomain is invalid.
    def create_url_with_subdomain(original_url, subdomain)
      new_environment = original_url

      if subdomain =~ /^[0-9a-z]+$/
        url_parts = URI.parse(original_url)
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
