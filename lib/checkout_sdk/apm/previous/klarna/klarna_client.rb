# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Apm
      class KlarnaClient < Client
        CREDIT_SESSIONS = 'credit-sessions'
        ORDERS = 'orders'
        CAPTURES = 'captures'
        VOIDS = 'voids'
        private_constant :CREDIT_SESSIONS, :ORDERS, :CAPTURES, :VOIDS

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY
        end

        # @param credit_session_request [CreditSessionRequest]
        def create_credit_session(credit_session_request)
          api_client.invoke_post(build_path(base_url, CREDIT_SESSIONS), sdk_authorization, credit_session_request)
        end

        # @param session_id [String]
        def get_credit_session(session_id)
          api_client.invoke_get(build_path(base_url, CREDIT_SESSIONS, session_id), sdk_authorization)
        end

        # @param payment_id [String]
        # @param order_capture_request [OrderCaptureRequest]
        def capture_payment(payment_id, order_capture_request)
          api_client.invoke_post(build_path(base_url, ORDERS, payment_id, CAPTURES),
                                 sdk_authorization,
                                 order_capture_request)
        end

        # @param payment_id [String]
        # @param void_request [CheckoutSdk::Payments::VoidRequest]
        def void_payment(payment_id, void_request)
          api_client.invoke_post(build_path(base_url, ORDERS, payment_id, VOIDS),
                                 sdk_authorization,
                                 void_request)
        end

        private

        def base_url
          sandbox? ? 'klarna-external' : 'klarna'
        end
      end
    end
  end
end
