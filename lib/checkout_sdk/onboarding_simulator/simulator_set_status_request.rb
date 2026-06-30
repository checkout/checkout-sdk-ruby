# frozen_string_literal: true

module CheckoutSdk
  module OnboardingSimulator
    # Request body for POST /simulate/entities/{entityId}/status.
    #
    # @!attribute status
    #   @return [String] {SimulatorEntityStatus}
    class SimulatorSetStatusRequest
      attr_accessor :status
    end
  end
end
