# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class HostedPaymentsClient < Client
      HOSTED_PAYMENTS = 'hosted-payments'

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY
      end

      # @param [HostedPaymentsSession] hosted_payments_session
      def create_hosted_payments_page_session(hosted_payments_session)
        api_client.invoke_post(HOSTED_PAYMENTS, sdk_authorization, hosted_payments_session)
      end

      # @param [String] hosted_payment_id
      def get_hosted_payments_page_details(hosted_payment_id)
        api_client.invoke_get(build_path(HOSTED_PAYMENTS, hosted_payment_id), sdk_authorization)
      end
    end
  end
end
