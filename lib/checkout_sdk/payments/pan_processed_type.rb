# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The preferred type of Primary Account Number (PAN) for the payment.
    #
    # Named after the .NET `PanProcessedType` enum, which maps the same property.
    module PanProcessedType
      # Indicates a preference for using the full card number.
      FPAN = 'fpan'
      # Indicates a preference for using the Checkout.com Network Token.
      DPAN = 'dpan'
    end
  end
end
