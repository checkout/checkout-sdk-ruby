# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The type of client the customer uses to initiate the payment.
    # Maps swagger `PaymentSetup.customer.device.client`.
    module PaymentSetupDeviceClient
      WEB = 'web'
      MOBILE_WEB = 'mobile_web'
      APP = 'app'
    end
  end
end
