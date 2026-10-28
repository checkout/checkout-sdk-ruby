# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A corporate sender, with type corporate. Used by card payouts, bank payouts and regular payments.
    # The reference is inherited from {Sender}.
    #
    # @!attribute company_name
    #   The sender's company name. For card payouts, this must be a valid legal name: a single character or
    #   all non-alphabetic characters return a field validation error.
    #   [Required]
    #   max 35 characters for card payouts
    #   @return [String]
    # @!attribute address
    #   The sender's address. For card payouts, the residential address of an individual sender or the
    #   registered corporate address of a corporate or government sender.
    #   [Required]
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute reference_type
    #   The type of identifier used as the reference. Card payouts only.
    #   [Required] for card payouts
    #   Enum: "other"
    #   @return [String]
    # @!attribute source_of_funds
    #   The source of the funds used to fund the card payout. Card payouts only.
    #   [Required] for card payouts
    #   Enum: "credit" "debit" "prepaid" "deposit_account" "mobile_money_account" "cash"
    #   @return [String] {SourceOfFunds}
    # @!attribute identification
    #   The sender's identification. For card payouts, required if the card's issuer_country is one of AR, BR,
    #   CO or PE.
    #   [Optional] Card payouts only.
    #   @return [CheckoutSdk::Common::AccountHolderIdentification]
    class CorporateSender < Sender
      attr_accessor :company_name,
                    :address,
                    :reference_type,
                    :source_of_funds,
                    :identification

      def initialize
        super(CheckoutSdk::Payments::SenderType::CORPORATE)
      end
    end
  end
end
