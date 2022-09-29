# frozen_string_literal: true

module CheckoutSdk
  # @!attribute secret_key
  #   @return [String]
  # @!attribute public_key
  #   @return [String]
  class StaticKeysSdkCredentials < SdkCredentials
    attr_reader :secret_key, :public_key

    # @param [String] secret_key
    # @param [String] public_key
    def initialize(secret_key, public_key)
      @secret_key = secret_key
      @public_key = public_key
    end

    # @param [String] authorization_type
    # @return [CheckoutSdk::SdkAuthorization]
    def get_authorization(authorization_type)
      case authorization_type
      when AuthorizationType::SECRET_KEY, AuthorizationType::SECRET_KEY_OR_OAUTH
        raise CheckoutAuthorizationException.invalid_key AuthorizationType::SECRET_KEY if secret_key.nil?

        SdkAuthorization.new(PlatformType::DEFAULT, @secret_key)
      when AuthorizationType::PUBLIC_KEY, AuthorizationType::PUBLIC_KEY_OR_OAUTH
        raise CheckoutAuthorizationException.invalid_key AuthorizationType::PUBLIC_KEY if public_key.nil?

        SdkAuthorization.new(PlatformType::DEFAULT, @public_key)
      else
        raise CheckoutAuthorizationException.invalid_authorization authorization_type
      end
    end
  end
end
