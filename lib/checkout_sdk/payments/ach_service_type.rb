# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Which ACH service to use for the payment, when `source.type` is `ach`.
    #
    # Named after the .NET `AchServiceType` enum and the PHP doc reference, which map the same
    # property.
    module AchServiceType
      SAME_DAY = 'same_day'
      STANDARD = 'standard'
    end
  end
end
