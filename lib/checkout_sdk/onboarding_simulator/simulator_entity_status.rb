# frozen_string_literal: true

module CheckoutSdk
  module OnboardingSimulator
    # Statuses accepted by POST /simulate/entities/{entityId}/status.
    module SimulatorEntityStatus
      DRAFT = 'draft'
      REQUIREMENTS_DUE = 'requirements_due'
      PENDING = 'pending'
      ACTIVE = 'active'
      RESTRICTED = 'restricted'
      REJECTED = 'rejected'
      INACTIVE = 'inactive'
    end
  end
end
