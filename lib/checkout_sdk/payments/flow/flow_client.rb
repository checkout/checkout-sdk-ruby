# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Client for Payment Flow API operations
    # [Beta]
    class FlowClient < Client
      PAYMENTS_PATH = 'payments'
      SESSIONS_PATH = 'sessions'
      SUBMIT_PATH = 'submit'
      CREATE_AND_SUBMIT_PATH = 'create-and-submit'

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      # Creates a Payment Session.
      # Use this endpoint to set up a payment session before collecting payment details from your customer.
      # [Beta]
      #
      # @param [Hash] payment_session_request
      def create_payment_session(payment_session_request)
        api_client.invoke_post(
          build_path(PAYMENTS_PATH, SESSIONS_PATH),
          sdk_authorization,
          payment_session_request
        )
      end

      # Submits a Payment Session.
      # Use this endpoint to submit payment details and process the payment for an existing session.
      # [Beta]
      #
      # @param [String] id - The unique identifier of the Payment Session
      # @param [Hash] submit_payment_session_request
      def submit_payment_session(id, submit_payment_session_request)
        api_client.invoke_post(
          build_path(PAYMENTS_PATH, SESSIONS_PATH, id, SUBMIT_PATH),
          sdk_authorization,
          submit_payment_session_request
        )
      end

      # Creates and submits a Payment Session in a single request.
      # Use this endpoint to create a payment session and immediately process the payment.
      # [Beta]
      #
      # @param [Hash] create_and_submit_payment_session_request
      def create_and_submit_payment_session(create_and_submit_payment_session_request)
        api_client.invoke_post(
          build_path(PAYMENTS_PATH, SESSIONS_PATH, CREATE_AND_SUBMIT_PATH),
          sdk_authorization,
          create_and_submit_payment_session_request
        )
      end
    end
  end
end