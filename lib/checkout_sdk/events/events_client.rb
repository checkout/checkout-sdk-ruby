# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Events
      class EventsClient < Client
        EVENT_TYPES = 'event-types'
        EVENTS = 'events'
        NOTIFICATIONS = 'notifications'
        WEBHOOKS = 'webhooks'
        EVENT_ID = 'eventId'
        RETRY = 'retry'
        private_constant :EVENT_TYPES, :EVENTS, :NOTIFICATIONS, :WEBHOOKS, :EVENT_ID, :RETRY

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
        end

        # @param [String,nil] version
        def retrieve_all_event_types(version = nil)
          query = "version=#{version}" unless version.nil?
          api_client.invoke_get(EVENT_TYPES, sdk_authorization, query)
        end

        # @param [EventsQueryFilter] query_filter
        def retrieve_events(query_filter)
          api_client.invoke_get(EVENTS, sdk_authorization, query_filter)
        end

        # @param [String] event_id
        def retrieve_event(event_id)
          api_client.invoke_get(build_path(EVENTS, event_id), sdk_authorization)
        end

        # @param [String] event_id
        # @param [String] notification_id
        def retrieve_event_notification(event_id, notification_id)
          api_client.invoke_get(build_path(EVENTS, event_id, NOTIFICATIONS, notification_id), sdk_authorization)
        end

        # @param [String] event_id
        # @param [String] webhook_id
        def retry_webhook(event_id, webhook_id)
          api_client.invoke_post(build_path(EVENTS, event_id, WEBHOOKS, webhook_id), sdk_authorization)
        end

        # @param [String] event_id
        def retry_all_webhooks(event_id)
          api_client.invoke_post(build_path(EVENTS, event_id, WEBHOOKS, RETRY), sdk_authorization)
        end
      end
    end
  end
end
