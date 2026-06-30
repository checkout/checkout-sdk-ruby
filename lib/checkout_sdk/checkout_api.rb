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
  # @!attribute financial
  #   @return [CheckoutSdk::Financial::FinancialClient]
  # @!attribute issuing
  #   @return [CheckoutSdk::Issuing::IssuingClient]
  # @!attribute contexts
  #   @return [CheckoutSdk::Payments::PaymentContextsClient]
  # @!attribute payment_sessions
  #   @return [CheckoutSdk::Payments::PaymentSessionsClient]
  # @!attribute payments_setups
  #   @return [CheckoutSdk::Payments::PaymentSetupsClient]
  # @!attribute flow
  #   @return [CheckoutSdk::Payments::FlowClient]
  # @!attribute forward
  #   @return [CheckoutSdk::Forward::ForwardClient]
  # @!attribute onboarding_simulator
  #   @return [CheckoutSdk::OnboardingSimulator::OnboardingSimulatorClient]
  # @!attribute agentic_commerce
  #   @return [CheckoutSdk::AgenticCommerce::AgenticCommerceClient]
  # @!attribute compliance_requests
  #   @return [CheckoutSdk::ComplianceRequests::ComplianceRequestsClient]
  # @!attribute standalone_account_updater
  #   @return [CheckoutSdk::StandaloneAccountUpdater::StandaloneAccountUpdaterClient]
  # @!attribute network_tokens
  #   @return [CheckoutSdk::NetworkTokens::NetworkTokensClient]
  # @!attribute payment_methods
  #   @return [CheckoutSdk::PaymentMethods::PaymentMethodsClient]
  # @!attribute applicants
  #   @return [CheckoutSdk::Identities::Applicants::ApplicantsClient]
  # @!attribute aml_screening
  #   @return [CheckoutSdk::Identities::AmlScreening::AmlScreeningClient]
  # @!attribute id_document_verification
  #   @return [CheckoutSdk::Identities::IdDocumentVerification::IdDocumentVerificationClient]
  # @!attribute identity_verification
  #   @return [CheckoutSdk::Identities::IdentityVerification::IdentityVerificationClient]
  # @!attribute face_authentication
  #   @return [CheckoutSdk::Identities::FaceAuthentication::FaceAuthenticationClient]
  # @!attribute apple_pay
  #   @return [CheckoutSdk::Payments::ApplePayClient]
  # @!attribute google_pay
  #   @return [CheckoutSdk::Payments::GooglePayClient]
  class CheckoutApi
    attr_reader :customers,
                :disputes,
                :forex,
                :hosted,
                :instruments,
                :links,
                :payments,
                :payments_setups,
                :flow,
                :reports,
                :sessions,
                :tokens,
                :ideal,
                :accounts,
                :workflows,
                :risk,
                :balances,
                :transfers,
                :metadata,
                :financial,
                :issuing,
                :contexts,
                :payment_sessions,
                :forward,
                :onboarding_simulator,
                :agentic_commerce,
                :compliance_requests,
                :standalone_account_updater,
                :network_tokens,
                :payment_methods,
                :applicants,
                :aml_screening,
                :id_document_verification,
                :identity_verification,
                :face_authentication,
                :apple_pay,
                :google_pay

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
      @financial = CheckoutSdk::Financial::FinancialClient.new api_client, configuration
      @issuing = CheckoutSdk::Issuing::IssuingClient.new api_client, configuration
      @contexts = CheckoutSdk::Payments::PaymentContextsClient.new api_client, configuration
      @payment_sessions = CheckoutSdk::Payments::PaymentSessionsClient.new api_client, configuration
      @payments_setups = CheckoutSdk::Payments::PaymentSetupsClient.new api_client, configuration
      @flow = CheckoutSdk::Payments::FlowClient.new api_client, configuration
      @forward = CheckoutSdk::Forward::ForwardClient.new(api_client, configuration)
      @onboarding_simulator = CheckoutSdk::OnboardingSimulator::OnboardingSimulatorClient.new(api_client, configuration)
      @agentic_commerce = CheckoutSdk::AgenticCommerce::AgenticCommerceClient.new(api_client, configuration)
      @compliance_requests = CheckoutSdk::ComplianceRequests::ComplianceRequestsClient.new(api_client, configuration)
      @standalone_account_updater =
        CheckoutSdk::StandaloneAccountUpdater::StandaloneAccountUpdaterClient.new(api_client, configuration)
      @network_tokens = CheckoutSdk::NetworkTokens::NetworkTokensClient.new(api_client, configuration)
      @payment_methods = CheckoutSdk::PaymentMethods::PaymentMethodsClient.new(api_client, configuration)
      @applicants = CheckoutSdk::Identities::Applicants::ApplicantsClient.new(api_client, configuration)
      @aml_screening = CheckoutSdk::Identities::AmlScreening::AmlScreeningClient.new(api_client, configuration)
      @id_document_verification =
        CheckoutSdk::Identities::IdDocumentVerification::IdDocumentVerificationClient.new(api_client, configuration)
      @identity_verification =
        CheckoutSdk::Identities::IdentityVerification::IdentityVerificationClient.new(api_client, configuration)
      @face_authentication =
        CheckoutSdk::Identities::FaceAuthentication::FaceAuthenticationClient.new(api_client, configuration)
      @apple_pay = CheckoutSdk::Payments::ApplePayClient.new(api_client, configuration)
      @google_pay = CheckoutSdk::Payments::GooglePayClient.new(api_client, configuration)
    end

    private

    # @param [CheckoutConfiguration] configuration
    # @return [ApiClient]
    def base_api_client(configuration)
      base_uri = configuration.environment.base_uri
      subdomain = configuration.environment_subdomain

      base_uri = subdomain.base_uri if subdomain&.base_uri

      ApiClient.new(configuration, base_uri)
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

    # @param [CheckoutConfiguration] configuration
    # @return [ApiClient]
    def forward_client(configuration)
      ApiClient.new(configuration, configuration.environment.forward_uri)
    end
  end
end
