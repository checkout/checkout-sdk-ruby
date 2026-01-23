# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute events
    #   @return [Hash(String=>Array(String))]
    class EventWorkflowCondition < WorkflowCondition
      attr_accessor :events

      def initialize
        super(CheckoutSdk::Workflows::WorkflowConditionType::EVENT)
      end
    end
  end
end
