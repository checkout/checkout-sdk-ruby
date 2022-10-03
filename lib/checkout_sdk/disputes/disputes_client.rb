# frozen_string_literal: true

module CheckoutSdk
  module Disputes
    class DisputesClient < Client
      DISPUTES = 'disputes'
      FILES = 'files'
      ACCEPT = 'accept'
      EVIDENCE = 'evidence'
      private_constant :DISPUTES, :FILES, :ACCEPT, :EVIDENCE

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH
      end

      # @param [DisputesQueryFilter] disputes_query_filter
      def query(disputes_query_filter)
        api_client.invoke_get(DISPUTES, sdk_authorization, disputes_query_filter)
      end

      # @param [String] dispute_id
      def get_dispute_details(dispute_id)
        api_client.invoke_get(build_path(DISPUTES, dispute_id), sdk_authorization)
      end

      # @param [String] dispute_id
      def accept(dispute_id)
        api_client.invoke_post(build_path(DISPUTES, dispute_id, ACCEPT), sdk_authorization)
      end

      # @param [String] dispute_id
      # @param [DisputeEvidence] dispute_evidence
      def put_evidence(dispute_id, dispute_evidence)
        api_client.invoke_put(build_path(DISPUTES, dispute_id, EVIDENCE), sdk_authorization, dispute_evidence)
      end

      # @param [String] dispute_id
      def get_evidence(dispute_id)
        api_client.invoke_get(build_path(DISPUTES, dispute_id, EVIDENCE), sdk_authorization)
      end

      # @param [String] dispute_id
      def submit_evidence(dispute_id)
        api_client.invoke_post(build_path(DISPUTES, dispute_id, EVIDENCE), sdk_authorization)
      end

      # @param [CheckoutSdk::Common::FileRequest] file_request
      def upload_file(file_request)
        api_client.submit_file(FILES, sdk_authorization, file_request)
      end

      # @param [String] file_id
      def get_file_details(file_id)
        api_client.invoke_get(build_path(FILES, file_id), sdk_authorization)
      end
    end
  end
end
