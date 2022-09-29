# frozen_string_literal: true

module CheckoutSdk
  module Forex
    class ForexClient < Client
      FOREX = 'forex/quotes'
      private_constant :FOREX

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::OAUTH)
      end

      # @param [QuoteRequest] quote_request
      def request_quote(quote_request)
        api_client.invoke_post(FOREX, sdk_authorization, quote_request)
      end
    end
  end
end
