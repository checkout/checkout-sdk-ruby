# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute url
    #   @return [String]
    # @!attribute headers
    #   @return [Hash{String => String}]
    # @!attribute signature
    #   @return [WebhookSignature]
    class WebhookWorkflowAction < WorkflowAction
      attr_accessor :url,
                    :headers,
                    :signature

      def initialize
        super(CheckoutSdk::Workflows::WorkflowActionType::WEBHOOK)
      end
    end
  end
end
