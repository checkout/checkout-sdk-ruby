# frozen_string_literal: true

module CheckoutSdk
  module Previous
    # @!attribute customers
    #   @return [CheckoutSdk::Customers::CustomerClient]
    # @!attribute klarna
    #   @return [CheckoutSdk::Previous::Apm::KlarnaClient]
    # @!attribute sepa
    #   @return [CheckoutSdk::Previous::Apm::SepaClient]
    # @!attribute payments
    #   @return [CheckoutSdk::Payments::PaymentsClient]
    # @!attribute tokens
    #   @return [CheckoutSdk::Tokens::TokensClient]
    class CheckoutApi
      attr_reader :customers,
                  :klarna,
                  :sepa,
                  :tokens,
                  :payments

      # @param [CheckoutConfiguration] configuration
      def initialize(configuration)
        api_client = base_api_client configuration
        @customers = CheckoutSdk::Customers::CustomersClient.new api_client, configuration
        @klarna = CheckoutSdk::Previous::Apm::KlarnaClient.new api_client, configuration
        @sepa = CheckoutSdk::Previous::Apm::SepaClient.new api_client, configuration
        @tokens = CheckoutSdk::Tokens::TokensClient.new api_client, configuration
        @payments = CheckoutSdk::Payments::PaymentsClient.new api_client, configuration
      end

      private

      # @param [CheckoutConfiguration] configuration
      # @return [ApiClient]
      def base_api_client(configuration)
        CheckoutSdk::ApiClient.new configuration, configuration.environment.base_uri
      end
    end
  end
end
