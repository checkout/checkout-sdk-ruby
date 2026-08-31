# frozen_string_literal: true

module CheckoutSdk
  module Previous
    class CheckoutPreviousStaticKeysSdkBuilder < StaticKeysBuilder
      SECRET_KEY_PATTERN = '^sk_(test_)?(\\w{8})-(\\w{4})-(\\w{4})-(\\w{4})-(\\w{12})$'
      PUBLIC_KEY_PATTERN = '^pk_(test_)?(\\w{8})-(\\w{4})-(\\w{4})-(\\w{4})-(\\w{12})$'
      private_constant :SECRET_KEY_PATTERN, :PUBLIC_KEY_PATTERN

      # The Previous (ABC) platform predates merchant-specific subdomains, so it is exempt from
      # the mandatory with_environment_subdomain/with_legacy_domain configuration.
      def requires_environment_subdomain?
        false
      end

      def build
        @secret_key_pattern = SECRET_KEY_PATTERN
        @public_key_pattern = PUBLIC_KEY_PATTERN
        super
        configuration = CheckoutConfiguration.new(
          PreviousStaticKeysSdkCredentials.new(secret_key, public_key),
          environment,
          http_client,
          multipart_http_client,
          logger
        )

        env_subdomain = environment_subdomain
        configuration.environment_subdomain = env_subdomain if env_subdomain

        CheckoutApi.new(configuration)
      end
    end
  end
end
