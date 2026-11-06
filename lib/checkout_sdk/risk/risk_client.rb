# frozen_string_literal: true

module CheckoutSdk
  module Risk
    #   @deprecated Risk endpoints are no longer supported officially, This module will be removed in a
    # future release.
    class RiskClient < Client
      RISK = 'risk'
      ASSESSMENTS = 'assessments'
      PRE_AUTHENTICATION = 'pre-authentication'
      PRE_CAPTURE = 'pre-capture'
      private_constant :RISK, :ASSESSMENTS, :PRE_AUTHENTICATION, :PRE_CAPTURE

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
      end

      # @param [Hash, PreAuthenticationAssessment] pre_authentication_request
      def pre_authentication_scan(pre_authentication_request)
        api_client.invoke_post(build_path(RISK, ASSESSMENTS, PRE_AUTHENTICATION),
                               sdk_authorization,
                               pre_authentication_request)
      end

      # @param [Hash, PreCaptureAssessment] pre_capture_request
      def pre_capture_scan(pre_capture_request)
        api_client.invoke_post(build_path(RISK, ASSESSMENTS, PRE_CAPTURE), sdk_authorization, pre_capture_request)
      end
    end
  end
end
