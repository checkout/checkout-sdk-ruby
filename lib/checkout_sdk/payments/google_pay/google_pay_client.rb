# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Client for the Google Pay endpoints. All endpoints require OAuth.
    class GooglePayClient < Client
      GOOGLEPAY = 'googlepay'
      ENROLLMENTS = 'enrollments'
      DOMAIN = 'domain'
      DOMAINS = 'domains'
      STATE = 'state'
      private_constant :GOOGLEPAY, :ENROLLMENTS, :DOMAIN, :DOMAINS, :STATE

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::OAUTH)
      end

      # @param [Hash, GooglePayEnrollmentRequest] enrollment_request
      def enroll_entity(enrollment_request)
        api_client.invoke_post(build_path(GOOGLEPAY, ENROLLMENTS),
                               sdk_authorization,
                               enrollment_request)
      end

      # @param [String] entity_id
      # @param [Hash, GooglePayDomainRequest] domain_request
      def register_domain(entity_id, domain_request)
        api_client.invoke_post(build_path(GOOGLEPAY, ENROLLMENTS, entity_id, DOMAIN),
                               sdk_authorization,
                               domain_request)
      end

      # @param [String] entity_id
      def get_registered_domains(entity_id)
        api_client.invoke_get(build_path(GOOGLEPAY, ENROLLMENTS, entity_id, DOMAINS),
                              sdk_authorization)
      end

      # @param [String] entity_id
      def get_enrollment_state(entity_id)
        api_client.invoke_get(build_path(GOOGLEPAY, ENROLLMENTS, entity_id, STATE),
                              sdk_authorization)
      end
    end
  end
end
