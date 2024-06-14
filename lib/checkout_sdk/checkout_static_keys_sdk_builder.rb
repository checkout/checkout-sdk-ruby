# frozen_string_literal: true

module CheckoutSdk
  class CheckoutStaticKeysSdkBuilder < StaticKeysBuilder
    SECRET_KEY_PATTERN = '^sk_(sbox_)?[a-z2-7]{26}[a-z2-7*#$=]$'
    PUBLIC_KEY_PATTERN = '^pk_(sbox_)?[a-z2-7]{26}[a-z2-7*#$=]$'
    private_constant :SECRET_KEY_PATTERN, :PUBLIC_KEY_PATTERN

    # @return [CheckoutSdk::CheckoutApi]
    def build
      @secret_key_pattern = SECRET_KEY_PATTERN
      @public_key_pattern = PUBLIC_KEY_PATTERN
      super
      configuration = CheckoutConfiguration.new(
        StaticKeysSdkCredentials.new(secret_key, public_key),
        environment,
        http_client,
        multipart_http_client,
        logger
      )

      configuration.environment_subdomain = environment_subdomain if environment_subdomain

      CheckoutApi.new(configuration)
    end
  end
end
