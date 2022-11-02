# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute name
    #   @return [String]
    # @!attribute active
    #   @return [TrueClass, FalseClass]
    class PatchWorkflow
      attr_accessor :name,
                    :active
    end
  end
end
