# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class PaymentsLinksClient < Client
      PAYMENT_LINKS = 'payment-links'

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY
      end

      # @param [Hash, PaymentLink] payment_link
      def create_payment_link(payment_link)
        api_client.invoke_post(PAYMENT_LINKS, sdk_authorization, payment_link)
      end

      # @param [String] payment_link_id
      def get_payment_link(payment_link_id)
        api_client.invoke_get(build_path(PAYMENT_LINKS, payment_link_id), sdk_authorization)
      end
    end
  end
end
