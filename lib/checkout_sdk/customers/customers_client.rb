# frozen_string_literal: true

module CheckoutSdk
  module Customers
    class CustomersClient < Client
      CUSTOMERS = 'customers'
      private_constant :CUSTOMERS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH
      end

      # @param [CustomerRequest] customer_request
      def create(customer_request)
        api_client.invoke_post(CUSTOMERS, sdk_authorization, customer_request)
      end

      # @param [String] customer_id
      def get(customer_id)
        api_client.invoke_get(build_path(CUSTOMERS, customer_id), sdk_authorization)
      end

      # @param [String] customer_id
      # @param [CustomerRequest] customer_request
      def update(customer_id, customer_request)
        api_client.invoke_patch(build_path(CUSTOMERS, customer_id), sdk_authorization, customer_request)
      end

      # @param [String] customer_id
      def delete(customer_id)
        api_client.invoke_delete(build_path(CUSTOMERS, customer_id), sdk_authorization)
      end
    end
  end
end
