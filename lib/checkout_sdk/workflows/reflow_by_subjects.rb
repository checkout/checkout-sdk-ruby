# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute subjects
    #   @return [Array(String)]
    class ReflowBySubjects < Reflow
      attr_accessor :subjects
    end
  end
end
