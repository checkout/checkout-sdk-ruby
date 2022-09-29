# frozen_string_literal: true

module CheckoutSdk
  class SdkAuthorization
    attr_accessor :platform_type, :credential

    # @param [String] platform_type {PlatformType}
    # @param [String] credential
    def initialize(platform_type, credential)
      @platform_type = platform_type
      @credential = credential
    end

    def authorization_header
      case @platform_type
      when PlatformType::PREVIOUS, PlatformType::CUSTOM
        @credential
      when PlatformType::DEFAULT, PlatformType::OAUTH
        "Bearer #{@credential}"
      else
        raise CheckoutAuthorizationException, 'Invalid platform type'
      end
    end
  end
end
