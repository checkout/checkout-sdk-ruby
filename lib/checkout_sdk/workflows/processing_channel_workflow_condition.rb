# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute processing_channels
    #   @return [Array(String)]
    class ProcessingChannelWorkflowCondition < WorkflowCondition
      attr_accessor :processing_channels

      def initialize
        super(CheckoutSdk::Workflows::WorkflowConditionType::PROCESSING_CHANNEL)
      end
    end
  end
end
