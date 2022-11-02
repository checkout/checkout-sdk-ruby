# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute name
    #   @return [String]
    # @!attribute active
    #   @return [TrueClass, FalseClass]
    # @!attribute conditions
    #   @return [Array(WorkflowCondition)]
    # @!attribute actions
    #   @return [Array(WorkflowAction)]
    class CreateWorkflow
      attr_accessor :name,
                    :active,
                    :conditions,
                    :actions
    end
  end
end
