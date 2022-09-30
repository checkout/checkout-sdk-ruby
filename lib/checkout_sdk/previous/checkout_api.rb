# frozen_string_literal: true

module CheckoutSdk
  module Previous
    # @!attribute customers
    #   @return [CheckoutSdk::Customers::CustomerClient]
    # @!attribute instruments
    #   @return [CheckoutSdk::Previous::Instruments::InstrumentsClient]
    # @!attribute tokens
    #   @return [CheckoutSdk::Tokens::TokensClient]
    # @!attribute klarna
    #   @return [CheckoutSdk::Previous::Apm::KlarnaClient]
    # @!attribute sepa
    #   @return [CheckoutSdk::Previous::Apm::SepaClient]
    class CheckoutApi
      attr_reader :customers,
                  :instruments,
                  :tokens,
                  :klarna,
                  :sepa

      # @param [CheckoutConfiguration] configuration
      def initialize(configuration)
        api_client = base_api_client configuration
        @customers = CheckoutSdk::Customers::CustomersClient.new api_client, configuration
        @instruments = CheckoutSdk::Previous::Instruments::InstrumentsClient.new api_client, configuration
        @tokens = CheckoutSdk::Tokens::TokensClient.new api_client, configuration
        @klarna = CheckoutSdk::Previous::Apm::KlarnaClient.new api_client, configuration
        @sepa = CheckoutSdk::Previous::Apm::SepaClient.new api_client, configuration
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
