# frozen_string_literal: true

module CheckoutSdk
  module Risk
    #   @deprecated Risk endpoints have been officially no longer supported, This module will be removed in a
    # future release.
    class RiskClient < Client
      PRE_AUTHENTICATION = 'risk/assessments/pre-authentication'
      PRE_CAPTURE = 'risk/assessments/pre-capture'
      private_constant :PRE_AUTHENTICATION, :PRE_CAPTURE

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
      end

      # @param [PreAuthenticationAssessment] pre_authentication_request
      def pre_authentication_scan(pre_authentication_request)
        api_client.invoke_post(PRE_AUTHENTICATION, sdk_authorization, pre_authentication_request)
      end

      # @param [PreCaptureAssessment] pre_capture_request
      def pre_capture_scan(pre_capture_request)
        api_client.invoke_post(PRE_CAPTURE, sdk_authorization, pre_capture_request)
      end
    end
  end
end
