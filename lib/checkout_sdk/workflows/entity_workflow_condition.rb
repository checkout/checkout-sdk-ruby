# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute entities
    #   @return [Array(String)]
    class EntityWorkflowCondition < WorkflowCondition
      attr_accessor :entities

      def initialize
        super CheckoutSdk::Workflows::WorkflowConditionType::ENTITY
      end
    end
  end
end
