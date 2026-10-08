# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The initialization state of a payment method on a Payment Setup.
    # Maps swagger `PaymentMethodInitialization.initialization`.
    module PaymentSetupPaymentMethodInitialization
      DISABLED = 'disabled'
      ENABLED = 'enabled'
    end
  end
end
