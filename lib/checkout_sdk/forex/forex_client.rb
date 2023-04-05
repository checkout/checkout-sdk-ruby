# frozen_string_literal: true

module CheckoutSdk
  module Forex
    class ForexClient < Client
      FOREX = 'forex'
      QUOTES = 'quotes'
      RATES = 'rates'
      private_constant :FOREX, :QUOTES, :RATES

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::OAUTH)
      end

      # @param [Hash, QuoteRequest] quote_request
      def request_quote(quote_request)
        api_client.invoke_post(build_path(FOREX, QUOTES), sdk_authorization, quote_request)
      end

      # @param [Hash, RatesQueryFilter] rates_query_filter
      def get_rates(rates_query_filter)
        api_client.invoke_get(build_path(FOREX, RATES), sdk_authorization, rates_query_filter)
      end
    end
  end
end
