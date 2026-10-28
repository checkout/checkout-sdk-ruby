# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Additional details about the instruction of a payout or an unreferenced refund.
    # Card payouts and unreferenced refunds use purpose and funds_transfer_type; bank payouts use scheme.
    #
    # @!attribute purpose
    #   The purpose of the card payout or unreferenced refund.
    #   Required if the card's issuer_country is one of AR, BD, CL, CO, EG, IN or MX.
    #   [Optional]
    #   Enum: "family_support" "expatriation" "travel_and_tourism" "education" "medical_treatment"
    #   "emergency_need" "leisure" "savings" "gifts" "donations" "financial_services" "it_services"
    #   "investment" "insurance" "loan_payment" "pension" "royalties" "other" "income"
    #   @return [String] {PaymentPurposeType}
    # @!attribute charge_bearer
    #   The charge bearer of a bank payout.
    #   [Optional]
    #   @deprecated Not in the current request specification; it only appears on the payout details
    #     response. Retained for backwards compatibility and will be removed in a future version.
    #   @return [String] {ChargeBearer}
    # @!attribute repair
    #   Whether the bank payout may be repaired.
    #   [Optional]
    #   @deprecated Not in the current request specification; it only appears on the payout details
    #     response. Retained for backwards compatibility and will be removed in a future version.
    #   @return [TrueClass, FalseClass]
    # @!attribute scheme
    #   An option to restrict the payment scheme type of a bank payout, when not available payouts will fail.
    #   [Optional]
    #   Enum: "local" "instant"
    #   @return [String] {InstructionScheme}
    # @!attribute quote_id
    #   The FX quote identifier of a bank payout.
    #   [Optional]
    #   @deprecated Not in the current request specification; it only appears on the payout details
    #     response. Retained for backwards compatibility and will be removed in a future version.
    #   @return [String]
    # @!attribute skip_expiry
    #   [Optional]
    #   @deprecated Not in the current specification of any instruction, so the API does not define it.
    #     Retained for backwards compatibility and will be removed in a future version.
    #   @return [TrueClass, FalseClass]
    # @!attribute funds_transfer_type
    #   The funds transfer type code for the type of card payout you're performing.
    #   You can only use codes that have been assigned to you by the card schemes and Checkout.com, based
    #   on your business case and requirements. If you have only been assigned one funds transfer type
    #   code, this field is optional. For unreferenced refunds it is required if
    #   processing.processing_speed is fast: use MI for Visa and C60 for Mastercard.
    #   [Required] for card payouts, [Optional] for unreferenced refunds
    #   @return [String]
    # @!attribute mvv
    #   [Optional]
    #   @deprecated Not in the current specification of any instruction, so the API does not define it.
    #     Retained for backwards compatibility and will be removed in a future version.
    #   @return [String]
    class PaymentInstruction
      attr_accessor :purpose,
                    :charge_bearer,
                    :repair,
                    :scheme,
                    :quote_id,
                    :skip_expiry,
                    :funds_transfer_type,
                    :mvv
    end
  end
end
