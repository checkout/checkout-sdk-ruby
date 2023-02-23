# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Reconciliation
      class ReconciliationClient < Client
        REPORTING = 'reporting'
        PAYMENTS = 'payments'
        STATEMENTS = 'statements'
        DOWNLOAD = 'download'
        private_constant :REPORTING, :PAYMENTS, :STATEMENTS, :DOWNLOAD

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
        end

        # @param [Hash, ReconciliationQueryPaymentsFilter] payments_filter
        def query_payments_report(payments_filter)
          api_client.invoke_get(build_path(REPORTING, PAYMENTS), sdk_authorization, payments_filter)
        end

        # @param [String] payment_id
        def single_payment_report(payment_id)
          api_client.invoke_get(build_path(REPORTING, PAYMENTS, payment_id), sdk_authorization)
        end

        # @param [Hash, CheckoutSdk::Common::DateRangeQueryFilter] data_range
        def query_statements_report(data_range)
          api_client.invoke_get(build_path(REPORTING, STATEMENTS), sdk_authorization, data_range)
        end

        # @param [Hash, CheckoutSdk::Common::DateRangeQueryFilter] data_range
        def retrieve_csv_payment_report(data_range)
          api_client.invoke_get(build_path(REPORTING, PAYMENTS, DOWNLOAD), sdk_authorization, data_range)
        end

        # @param [String] statement_id
        def retrieve_csv_single_statement_report(statement_id)
          api_client.invoke_get(build_path(REPORTING, STATEMENTS, statement_id, PAYMENTS, DOWNLOAD), sdk_authorization)
        end

        # @param [Hash, CheckoutSdk::Common::DateRangeQueryFilter] data_range
        def retrieve_csv_statements_report(data_range)
          api_client.invoke_get(build_path(REPORTING, STATEMENTS, DOWNLOAD), sdk_authorization, data_range)
        end
      end
    end
  end
end
