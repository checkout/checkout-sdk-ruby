# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute type
    #   @return [String] {WorkflowConditionType}
    class WorkflowCondition
      attr_reader :type

      protected

      # @abstract
      # @param [String] {WorkflowConditionType}
      def initialize(type)
        @type = type
      end
    end
  end
end
