# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    class SessionsClient < Client
      SESSIONS = 'sessions'
      COLLECT_DATA = 'collect-data'
      COMPLETE = 'complete'
      ISSUER_FINGERPRINT = 'issuer-fingerprint'
      private_constant :SESSIONS, :COLLECT_DATA, :COMPLETE, :ISSUER_FINGERPRINT

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::OAUTH
      end

      # @param [SessionRequest] session_request
      def request_session(session_request)
        api_client.invoke_post(SESSIONS, sdk_authorization, session_request)
      end

      # @param [String] session_id
      # @param [String, nil] session_secret
      def get_session_details(session_id, session_secret = nil)
        api_client.invoke_get(build_path(SESSIONS, session_id), custom_sdk_authorization(session_secret))
      end

      # @param [String] session_id
      # @param [ChannelData] channel_data
      # @param [String, nil] session_secret
      def update_session(session_id, channel_data, session_secret = nil)
        api_client.invoke_put(build_path(SESSIONS, session_id, COLLECT_DATA),
                              custom_sdk_authorization(session_secret),
                              channel_data)
      end

      # @param [String] session_id
      # @param [String, nil] session_secret
      def complete_session(session_id, session_secret = nil)
        api_client.invoke_post(build_path(SESSIONS, session_id, COMPLETE), custom_sdk_authorization(session_secret))
      end

      # @param [String] session_id
      # @param [ThreeDsMethodCompletionRequest] three_ds_method_completion_request
      # @param [String, nil] session_secret
      def update_3ds_method_completion(session_id, three_ds_method_completion_request, session_secret = nil)
        api_client.invoke_put(build_path(SESSIONS, session_id, ISSUER_FINGERPRINT),
                              custom_sdk_authorization(session_secret),
                              three_ds_method_completion_request)
      end

      # @param [String, nil] session_secret
      def custom_sdk_authorization(session_secret = nil)
        if session_secret.nil?
          sdk_authorization
        else
          SessionSecretCredentials.new(session_secret) \
                                  .get_authorization(AuthorizationType::CUSTOM)
        end
      end
    end
  end
end
