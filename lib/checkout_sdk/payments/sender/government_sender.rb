# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A government sender, with type government. Card payouts only.
    #
    # @!attribute company_name
    #   The sender's company name. This must be a valid legal name: a single character or all non-alphabetic
    #   characters return a field validation error.
    #   [Required]
    #   max 35 characters
    #   @return [String]
    # @!attribute address
    #   The sender's registered corporate address.
    #   [Required]
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute reference
    #   The unique identifier for the sender, for example a customer number. Only alphanumeric characters
    #   are supported.
    #   [Required]
    #   min 5 characters
    #   max 15 characters
    #   @return [String]
    # @!attribute reference_type
    #   The type of identifier used as the reference.
    #   [Required]
    #   Enum: "other"
    #   @return [String]
    # @!attribute source_of_funds
    #   The source of the funds used to fund the card payout.
    #   [Required]
    #   Enum: "credit" "debit" "prepaid" "deposit_account" "mobile_money_account" "cash"
    #   @return [String] {SourceOfFunds}
    # @!attribute identification
    #   The sender's identification. Required if the card's issuer_country is one of AR, BR, CO or PE.
    #   [Optional]
    #   @return [CheckoutSdk::Common::AccountHolderIdentification]
    class GovernmentSender < Sender
      attr_accessor :company_name,
                    :address,
                    :reference,
                    :reference_type,
                    :source_of_funds,
                    :identification

      def initialize
        super(CheckoutSdk::Payments::SenderType::GOVERNMENT)
      end
    end
  end
end
