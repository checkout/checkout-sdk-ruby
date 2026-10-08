# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The payment method status on a Payment Setup.
    # Maps swagger `PaymentMethodStatus`.
    module PaymentSetupPaymentMethodStatus
      UNAVAILABLE = 'unavailable'
      ACTION_REQUIRED = 'action_required'
      READY = 'ready'
      INITIALIZATION_REQUIRED = 'initialization_required'
      INVALID = 'invalid'
    end
  end
end
