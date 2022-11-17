# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Webhooks
      # @!attribute url
      #   @return [String]
      # @!attribute active
      #   @return [TrueClass, FalseClass]
      # @!attribute headers
      #   @return [Hash(String=>String)]
      # @!attribute content_type
      #   @return [String]
      # @!attribute event_types
      #   @return [Array(String)]
      class WebhookRequest
        attr_accessor :url,
                      :active,
                      :headers,
                      :content_type,
                      :event_types
      end
    end
  end
end
