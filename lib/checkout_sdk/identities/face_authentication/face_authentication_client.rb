# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module FaceAuthentication
      # Client for the Identities — Face Authentication API.
      class FaceAuthenticationClient < Client
        FACE_AUTHENTICATIONS = 'face-authentications'
        ANONYMIZE = 'anonymize'
        ATTEMPTS = 'attempts'
        ASSETS = 'assets'
        private_constant :FACE_AUTHENTICATIONS, :ANONYMIZE, :ATTEMPTS, :ASSETS

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
        end

        # @param [Hash, FaceAuthenticationRequest] request
        def create_face_authentication(request)
          api_client.invoke_post(FACE_AUTHENTICATIONS, sdk_authorization, request)
        end

        # @param [String] face_authentication_id
        def get_face_authentication(face_authentication_id)
          api_client.invoke_get(build_path(FACE_AUTHENTICATIONS, face_authentication_id),
                                sdk_authorization)
        end

        # @param [String] face_authentication_id
        def anonymize_face_authentication(face_authentication_id)
          api_client.invoke_post(
            build_path(FACE_AUTHENTICATIONS, face_authentication_id, ANONYMIZE),
            sdk_authorization
          )
        end

        # Create a new attempt for an existing face authentication.
        # @param [String] face_authentication_id
        # @param [Hash, FaceAuthenticationAttemptRequest] attempt_request
        def create_face_authentication_attempt(face_authentication_id, attempt_request)
          api_client.invoke_post(
            build_path(FACE_AUTHENTICATIONS, face_authentication_id, ATTEMPTS),
            sdk_authorization,
            attempt_request
          )
        end

        # @param [String] face_authentication_id
        def get_face_authentication_attempts(face_authentication_id)
          api_client.invoke_get(
            build_path(FACE_AUTHENTICATIONS, face_authentication_id, ATTEMPTS),
            sdk_authorization
          )
        end

        # @param [String] face_authentication_id
        # @param [String] attempt_id
        def get_face_authentication_attempt(face_authentication_id, attempt_id)
          api_client.invoke_get(
            build_path(FACE_AUTHENTICATIONS, face_authentication_id, ATTEMPTS, attempt_id),
            sdk_authorization
          )
        end

        # Retrieve the assets (face images and videos) captured during a face authentication attempt.
        # @param [String] face_authentication_id
        # @param [String] attempt_id
        # @param [Hash] query the pagination query parameters (skip and limit)
        def get_face_authentication_attempt_assets(face_authentication_id, attempt_id, query = nil)
          api_client.invoke_get(
            build_path(FACE_AUTHENTICATIONS, face_authentication_id, ATTEMPTS, attempt_id, ASSETS),
            sdk_authorization,
            query
          )
        end
      end
    end
  end
end
