# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The type of payment on a SEPA instrument.
    #
    # Declared lowercase by the SEPA instrument schemas. Do not confuse this with
    # {BacsPaymentType}, which declares the same two concepts capitalized, or with
    # {CheckoutSdk::Payments::PaymentType}, which is the payment-level enum.
    module SepaPaymentType
      RECURRING = 'recurring'
      REGULAR = 'regular'
    end
  end
end
