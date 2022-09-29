# frozen_string_literal: true

module CheckoutSdk
  # @!attribute customers
  #   @return [CheckoutSdk::Customers::CustomersClient]
  # @!attribute disputes
  #   @return [CheckoutSdk::Disputes::DisputesClient]
  # @!attribute forex
  #   @return [CheckoutSdk::Forex::ForexClient]
  # @!attribute instruments
  #   @return [CheckoutSdk::Instruments::InstrumentsClient]
  # @!attribute payments
  #   @return [CheckoutSdk::Payments::PaymentsClient]
  # @!attribute sessions
  #   @return [CheckoutSdk::Sessions::SessionsClient]
  # @!attribute tokens
  #   @return [CheckoutSdk::Tokens::TokensClient]
  # @!attribute ideal
  #   @return [CheckoutSdk::Apm::IdealClient]
  class CheckoutApi
    attr_reader :customers,
                :disputes,
                :forex,
                :instruments,
                :payments,
                :sessions,
                :tokens,
                :ideal

    # @param [CheckoutConfiguration] configuration
    def initialize(configuration)
      api_client = base_api_client configuration
      @customers = CheckoutSdk::Customers::CustomersClient.new api_client, configuration
      @disputes = CheckoutSdk::Disputes::DisputesClient.new api_client, configuration
      @forex = CheckoutSdk::Forex::ForexClient.new api_client, configuration
      @instruments = CheckoutSdk::Instruments::InstrumentsClient.new api_client, configuration
      @payments = CheckoutSdk::Payments::PaymentsClient.new api_client, configuration
      @sessions = CheckoutSdk::Sessions::SessionsClient.new api_client, configuration
      @tokens = CheckoutSdk::Tokens::TokensClient.new api_client, configuration
      @ideal = CheckoutSdk::Apm::IdealClient.new api_client, configuration
    end

    private

    # @param [CheckoutConfiguration] configuration
    # @return [ApiClient]
    def base_api_client(configuration)
      CheckoutSdk::ApiClient.new configuration, configuration.environment.base_uri
    end
  end
end
