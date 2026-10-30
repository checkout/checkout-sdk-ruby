# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Details about the payment instruction of a hosted payments session.
    # Hosted payments use purpose only.
    #
    # @!attribute purpose
    #   The purpose of the payment. This field might be required for AFT transactions depending on the
    #   card's issuer_country.
    #   [Optional]
    #   Enum: "donations" "education" "emergency_need" "expatriation" "family_support" "financial_services"
    #   "gifts" "income" "insurance" "investment" "it_services" "leisure" "loan_payment" "medical_treatment"
    #   "other" "pension" "royalties" "savings" "travel_and_tourism"
    #   @return [String] {PaymentPurposeType}
    class HostedPaymentInstruction
      attr_accessor :purpose
    end
  end
end
