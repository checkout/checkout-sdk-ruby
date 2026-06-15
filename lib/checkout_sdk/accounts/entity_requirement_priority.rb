# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Priority of a sub-entity requirement. "critical" if the deadline is within 7 days,
    # otherwise "high" by default.
    module EntityRequirementPriority
      HIGH = 'high'
      CRITICAL = 'critical'
    end
  end
end
