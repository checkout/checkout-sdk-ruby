# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The payment type of a payment request.
    # Enum: "Regular" "Recurring" "MOTO" "Installment" "PayLater" "Unscheduled"
    module PaymentType
      REGULAR = 'Regular'
      RECURRING = 'Recurring'
      MOTO = 'MOTO'
      INSTALLMENT = 'Installment'
      PAY_LATER = 'PayLater'
      UNSCHEDULED = 'Unscheduled'
    end
  end
end
