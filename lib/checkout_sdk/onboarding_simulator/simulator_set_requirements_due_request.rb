# frozen_string_literal: true

module CheckoutSdk
  module OnboardingSimulator
    # Request body for POST /simulate/entities/{entityId}/requirements-due.
    #
    # @!attribute fields
    #   @return [Array(String)] Requirement field paths to mark as due
    #     (e.g. ["individual.identification.document"]).
    class SimulatorSetRequirementsDueRequest
      attr_accessor :fields
    end
  end
end
