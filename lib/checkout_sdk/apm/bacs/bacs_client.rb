# frozen_string_literal: true

module CheckoutSdk
  module Apm
    # Bacs Direct Debit client.
    class BacsClient < Client
      APMS = 'apms'
      BACS = 'bacs'
      NOTIFICATIONS = 'notifications'
      private_constant :APMS, :BACS, :NOTIFICATIONS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
      end

      # Sends a Bacs Direct Debit pre-notification (advance notice) to a payer ahead
      # of collecting funds from their account.
      #
      # @param [Hash, BacsNotificationRequest] bacs_notification_request
      # @return [Hash] the BacsNotificationResponse, carrying event_id.
      def send_notification(bacs_notification_request)
        api_client.invoke_post(build_path(APMS, BACS, NOTIFICATIONS),
                               sdk_authorization,
                               bacs_notification_request)
      end
    end
  end
end
