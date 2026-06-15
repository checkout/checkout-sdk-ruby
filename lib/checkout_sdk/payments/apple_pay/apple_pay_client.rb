# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Client for the Apple Pay endpoints.
    class ApplePayClient < Client
      APPLEPAY = 'applepay'
      CERTIFICATES = 'certificates'
      ENROLLMENTS = 'enrollments'
      SIGNING_REQUESTS = 'signing-requests'
      private_constant :APPLEPAY, :CERTIFICATES, :ENROLLMENTS, :SIGNING_REQUESTS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::PUBLIC_KEY)
      end

      # Upload a payment processing certificate. Public key auth per swagger.
      # @param [Hash, ApplePayCertificateRequest] certificate_request
      def upload_certificate(certificate_request)
        api_client.invoke_post(build_path(APPLEPAY, CERTIFICATES),
                               sdk_authorization,
                               certificate_request)
      end

      # Enroll a domain to the Apple Pay Service. OAuth required.
      # @param [Hash, ApplePayEnrollmentRequest] enrollment_request
      def enroll_domain(enrollment_request)
        api_client.invoke_post(build_path(APPLEPAY, ENROLLMENTS),
                               sdk_authorization(CheckoutSdk::AuthorizationType::OAUTH),
                               enrollment_request)
      end

      # Generate a certificate signing request. Public key auth per swagger.
      # @param [Hash, ApplePaySigningRequest] signing_request
      def generate_signing_request(signing_request)
        api_client.invoke_post(build_path(APPLEPAY, SIGNING_REQUESTS),
                               sdk_authorization,
                               signing_request)
      end
    end
  end
end
