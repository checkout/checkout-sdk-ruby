# frozen_string_literal: true

module CheckoutSdk
  # @!attribute customers
  #   @return [CheckoutSdk::Customers::CustomersClient]
  # @!attribute disputes
  #   @return [CheckoutSdk::Disputes::DisputesClient]
  # @!attribute forex
  #   @return [CheckoutSdk::Forex::ForexClient]
  # @!attribute hosted
  #   @return [CheckoutSdk::Payments::HostedPaymentsClient]
  # @!attribute instruments
  #   @return [CheckoutSdk::Instruments::InstrumentsClient]
  # @!attribute links
  #   @return [CheckoutSdk::Payments::PaymentsLinksClient]
  # @!attribute payments
  #   @return [CheckoutSdk::Payments::PaymentsClient]
  # @!attribute reports
  #   @return [CheckoutSdk::Reports::ReportsClient]
  # @!attribute sessions
  #   @return [CheckoutSdk::Sessions::SessionsClient]
  # @!attribute tokens
  #   @return [CheckoutSdk::Tokens::TokensClient]
  # @!attribute ideal
  #   @return [CheckoutSdk::Apm::IdealClient]
  # @!attribute accounts
  #   @return [CheckoutSdk::Accounts::AccountsClient]
  # @!attribute workflows
  #   @return [CheckoutSdk::Workflows::WorkflowsClient]
  # @!attribute risk
  #   @return [CheckoutSdk::Risk::RiskClient]
  # @!attribute balances
  #   @return [CheckoutSdk::Balances::BalancesClient]
  # @!attribute transfers
  #   @return [CheckoutSdk::Transfers::TransfersClient]
  # @!attribute metadata
  #   @return [CheckoutSdk::Metadata::MetadataClient]
  class CheckoutApi
    attr_reader :customers,
                :disputes,
                :forex,
                :hosted,
                :instruments,
                :links,
                :payments,
                :reports,
                :sessions,
                :tokens,
                :ideal,
                :accounts,
                :workflows,
                :risk,
                :balances,
                :transfers,
                :metadata

    # @param [CheckoutConfiguration] configuration
    def initialize(configuration)
      api_client = base_api_client configuration
      @customers = CheckoutSdk::Customers::CustomersClient.new api_client, configuration
      @disputes = CheckoutSdk::Disputes::DisputesClient.new api_client, configuration
      @forex = CheckoutSdk::Forex::ForexClient.new api_client, configuration
      @hosted = CheckoutSdk::Payments::HostedPaymentsClient.new api_client, configuration
      @instruments = CheckoutSdk::Instruments::InstrumentsClient.new api_client, configuration
      @links = CheckoutSdk::Payments::PaymentsLinksClient.new api_client, configuration
      @payments = CheckoutSdk::Payments::PaymentsClient.new api_client, configuration
      @reports = CheckoutSdk::Reports::ReportsClient.new api_client, configuration
      @sessions = CheckoutSdk::Sessions::SessionsClient.new api_client, configuration
      @tokens = CheckoutSdk::Tokens::TokensClient.new api_client, configuration
      @ideal = CheckoutSdk::Apm::IdealClient.new api_client, configuration
      @workflows = CheckoutSdk::Workflows::WorkflowsClient.new api_client, configuration
      @accounts = CheckoutSdk::Accounts::AccountsClient.new(api_client, files_client(configuration), configuration)
      @risk = CheckoutSdk::Risk::RiskClient.new api_client, configuration
      @balances = CheckoutSdk::Balances::BalancesClient.new(balances_client(configuration), configuration)
      @transfers = CheckoutSdk::Transfers::TransfersClient.new(transfers_client(configuration), configuration)
      @metadata = CheckoutSdk::Metadata::MetadataClient.new api_client, configuration
    end

    private

    # @param [CheckoutConfiguration] configuration
    # @return [ApiClient]
    def base_api_client(configuration)
      ApiClient.new(configuration, configuration.environment.base_uri)
    end

    # @param [CheckoutConfiguration] configuration
    # @return [ApiClient]
    def files_client(configuration)
      ApiClient.new(configuration, configuration.environment.files_uri)
    end

    # @param [CheckoutConfiguration] configuration
    # @return [ApiClient]
    def balances_client(configuration)
      ApiClient.new(configuration, configuration.environment.balances_uri)
    end

    # @param [CheckoutConfiguration] configuration
    # @return [ApiClient]
    def transfers_client(configuration)
      ApiClient.new(configuration, configuration.environment.transfers_uri)
    end
  end
end
