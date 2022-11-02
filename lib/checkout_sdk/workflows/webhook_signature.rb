# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute method
    #   @return [String]
    # @!attribute key
    #   @return [String]
    class WebhookSignature
      attr_accessor :method,
                    :key
    end
  end
end
