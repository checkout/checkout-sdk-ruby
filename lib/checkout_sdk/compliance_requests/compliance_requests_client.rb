# frozen_string_literal: true

module CheckoutSdk
  module ComplianceRequests
    # Client for the Compliance Requests API.
    class ComplianceRequestsClient < Client
      COMPLIANCE_REQUESTS = 'compliance-requests'
      private_constant :COMPLIANCE_REQUESTS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # Retrieve an existing compliance request by payment ID.
      # @param [String] payment_id
      def get_compliance_request(payment_id)
        api_client.invoke_get(build_path(COMPLIANCE_REQUESTS, payment_id), sdk_authorization)
      end

      # Respond to a compliance request.
      # @param [String] payment_id
      # @param [Hash, ComplianceResponseRequest] compliance_response_request
      def respond_to_compliance_request(payment_id, compliance_response_request)
        api_client.invoke_post(
          build_path(COMPLIANCE_REQUESTS, payment_id),
          sdk_authorization,
          compliance_response_request
        )
      end
    end
  end
end
