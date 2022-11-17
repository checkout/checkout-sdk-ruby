# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Webhooks
      class WebhooksClient < Client
        WEBHOOKS = 'webhooks'
        private_constant :WEBHOOKS

        # @param [ApiClient] api_client
        # @param [CheckoutConfiguration] configuration
        def initialize(api_client, configuration)
          super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY)
        end

        def retrieve_webhooks
          api_client.invoke_get(WEBHOOKS, sdk_authorization)
        end

        # @param [WebhookRequest] webhook_request
        # @param [String,nil] idempotency_key
        def register_webhook(webhook_request, idempotency_key = nil)
          api_client.invoke_post(WEBHOOKS, sdk_authorization, webhook_request, idempotency_key)
        end

        # @param [String] webhook_id
        def retrieve_webhook(webhook_id)
          api_client.invoke_get(build_path(WEBHOOKS, webhook_id), sdk_authorization)
        end

        # @param [String] webhook_id
        # @param [WebhookRequest] webhook_request
        def update_webhook(webhook_id, webhook_request)
          api_client.invoke_put(build_path(WEBHOOKS, webhook_id), sdk_authorization, webhook_request)
        end

        # @param [String] webhook_id
        # @param [WebhookRequest] webhook_request
        def patch_webhook(webhook_id, webhook_request)
          api_client.invoke_patch(build_path(WEBHOOKS, webhook_id), sdk_authorization, webhook_request)
        end

        # @param [String] webhook_id
        def remove_webhook(webhook_id)
          api_client.invoke_delete(build_path(WEBHOOKS, webhook_id), sdk_authorization)
        end
      end
    end
  end
end
