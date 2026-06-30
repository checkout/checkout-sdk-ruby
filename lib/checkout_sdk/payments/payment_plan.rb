# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Details of a recurring subscription or installment plan associated with a payment.
    #
    # @!attribute amount_variability
    #   @return [String] Recurring-only. One of "Fixed" or "Variable".
    # @!attribute financing
    #   @return [TrueClass, FalseClass] Installment-only.
    # @!attribute amount
    #   @return [Integer] The amount to charge for each payment in the plan, in the minor currency unit.
    #     Required when source.type is "blik", amount_variability is "Fixed", and the recurring
    #     agreement is created without an initial payment (amount set to 0).
    # @!attribute days_between_payments
    #   @return [Integer]
    # @!attribute total_number_of_payments
    #   @return [Integer]
    # @!attribute current_payment_number
    #   @return [Integer]
    # @!attribute expiry
    #   @return [String] ISO 8601 date-time
    # @!attribute name
    #   @return [String] The name of the payment plan. Required when source.type is "blik".
    #     For Blik merchant-initiated requests using an external partner_agreement_id, this value
    #     is used as the Blik Alias Label. Max 35 characters.
    # @!attribute start_date
    #   @return [String] The date on which the first payment will be taken, in YYYYMMDD format.
    #     Required when source.type is "blik" and the recurring agreement is created without an
    #     initial payment (amount set to 0).
    class PaymentPlan
      attr_accessor :amount_variability,
                    :financing,
                    :amount,
                    :days_between_payments,
                    :total_number_of_payments,
                    :current_payment_number,
                    :expiry,
                    :name,
                    :start_date
    end
  end
end
