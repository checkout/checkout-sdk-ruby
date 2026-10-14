# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Risk assessment settings for the Payment Setup.
    # Maps the swagger `PaymentSetup.risk` object. Sent under the `risk` key.
    #
    # The Payment Setup request is a Hash, so pass { enabled: false } directly, or convert an
    # instance first with CheckoutSdk::JsonSerializer.to_custom_hash(risk).
    class PaymentSetupRisk
      # Indicates whether a risk assessment should be performed.
      # [Optional]
      # Default: true
      # @return [TrueClass, FalseClass]
      attr_accessor :enabled
    end
  end
end
