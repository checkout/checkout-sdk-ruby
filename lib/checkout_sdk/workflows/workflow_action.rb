# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute type
    #   @return [String] {WorkflowActionType}
    class WorkflowAction
      attr_reader :type

      protected

      # @abstract
      # @param [String] {WorkflowActionType}
      def initialize(type)
        @type = type
      end
    end
  end
end
