# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The payment scheme type of a bank payout instruction.
    # Enum: "local" "instant"
    class InstructionScheme
      # @deprecated Not in the current specification, which only lists local and instant. Retained for
      #   backwards compatibility and will be removed in a future version.
      SWIFT = 'swift'
      LOCAL = 'local'
      INSTANT = 'instant'
    end
  end
end
