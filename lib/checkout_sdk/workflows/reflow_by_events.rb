# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    # @!attribute events
    #   @return [Array(String)]
    class ReflowByEvents < Reflow
      attr_accessor :events
    end
  end
end
