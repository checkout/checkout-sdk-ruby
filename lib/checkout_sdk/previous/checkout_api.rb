# frozen_string_literal: true

module CheckoutSdk
  module Previous
    # @!attribute klarna
    #   @return [CheckoutSdk::Previous::Apm::Klarna::KlarnaClient]
    # @!attribute sepa
    #   @return [CheckoutSdk::Previous::Apm::Sepa::SepaClient]
    class CheckoutApi
      attr_reader :klarna,
                  :sepa

      # @param [CheckoutConfiguration] configuration
      def initialize(configuration)
        api_client = base_api_client configuration
        @klarna = CheckoutSdk::Previous::Apm::Klarna::KlarnaClient.new api_client, configuration
        @sepa = CheckoutSdk::Previous::Apm::Sepa::SepaClient.new api_client, configuration
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
