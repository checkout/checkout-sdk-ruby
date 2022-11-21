# frozen_string_literal: true

module CheckoutSdk
  module Reports
    class ReportsClient < Client
      REPORTS = 'reports'
      FILES = 'files'

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH
      end

      # @param [ReportsQuery] query_filter
      def get_all_reports(query_filter)
        api_client.invoke_get(REPORTS, sdk_authorization, query_filter)
      end

      # @param [String] report_id
      def get_report_details(report_id)
        api_client.invoke_get(build_path(REPORTS, report_id), sdk_authorization)
      end

      # @param [String] report_id
      # @param [String] file_id
      def get_report_file(report_id, file_id)
        api_client.invoke_get(build_path(REPORTS, report_id, FILES, file_id), sdk_authorization)
      end
    end
  end
end
