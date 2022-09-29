# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute session_secret
    #   @return [String]
    class SessionSecretCredentials < SdkCredentials
      attr_accessor :session_secret

      # @param [String] session_secret
      # @return [SessionSecretCredentials]
      def initialize(session_secret)
        @session_secret = session_secret
      end

      # @param [String] authorization_type
      # @return [CheckoutSdk::SdkAuthorization]
      def get_authorization(authorization_type)
        if authorization_type != AuthorizationType::CUSTOM
          raise CheckoutAuthorizationException.invalid_authorization AuthorizationType::CUSTOM
        end
        raise CheckoutAuthorizationException.invalid_key AuthorizationType::CUSTOM if @session_secret.nil?

        SdkAuthorization.new PlatformType::CUSTOM, @session_secret
      end
    end
  end
end
