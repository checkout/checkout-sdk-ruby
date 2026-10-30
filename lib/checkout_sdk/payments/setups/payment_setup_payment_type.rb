# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The type of payment on a Payment Setup. Maps swagger `PaymentSetup.payment_type`.
    #
    # The Payment Setups API declares these values in lowercase, unlike {PaymentType}, which is the
    # capitalized enum of the payments API. Use this module for the :payment_type key of a Payment
    # Setup request. When :payment_type is not sent, the API uses "regular".
    module PaymentSetupPaymentType
      REGULAR = 'regular'
      RECURRING = 'recurring'
      MOTO = 'moto'
      INSTALLMENT = 'installment'
      PAY_LATER = 'pay_later'
      UNSCHEDULED = 'unscheduled'
    end
  end
end
