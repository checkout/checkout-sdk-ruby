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

    # Applies subdomain transformation to any given URI, prepending the subdomain to the host.
    #
    # @param original_url [String] The original URL to transform.
    # @param subdomain [String] The subdomain to prepend to the host.
    # @return [String] The transformed URL with subdomain.
    # @raise [CheckoutArgumentException] If the subdomain is not a valid merchant-specific
    #   subdomain.
    def create_url_with_subdomain(original_url, subdomain)
      unless subdomain =~ /\A(?:pl-)?[a-z0-9]+\z/
        raise CheckoutArgumentException,
              'invalid environment subdomain - provide your merchant-specific subdomain, ' \
              'typically your client ID excluding the cli_ prefix (see ' \
              'https://api-reference.checkout.com/#section/Base-URLs)'
      end

      url_parts = URI.parse(original_url)
      new_host = "#{subdomain}.#{url_parts.host}"

      port = url_parts.scheme == 'https' && url_parts.port == 443 ? nil : url_parts.port

      URI::Generic.build(
        scheme: url_parts.scheme,
        userinfo: url_parts.userinfo,
        host: new_host,
        port: port,
        path: url_parts.path,
        query: url_parts.query,
        fragment: url_parts.fragment
      ).to_s
    end
  end
end
