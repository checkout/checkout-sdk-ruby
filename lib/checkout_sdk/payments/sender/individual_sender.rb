# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # An individual sender, with type individual. Used by card payouts, bank payouts and regular payments.
    #
    # @!attribute first_name
    #   The sender's legal first name. For card payouts, the combination of first_name, middle_name and
    #   last_name should exceed 3 letters in length, and a single character or all non-alphabetic
    #   characters return a field validation error.
    #   [Required]
    #   max 50 characters for card payouts
    #   @return [String]
    # @!attribute middle_name
    #   The sender's middle name. Card payouts only.
    #   [Optional]
    #   max 50 characters
    #   @return [String]
    # @!attribute last_name
    #   The sender's legal last name. For card payouts, the combination of first_name, middle_name and
    #   last_name must exceed 3 letters in length, and a single character or all non-alphabetic characters
    #   return a field validation error.
    #   [Required]
    #   max 50 characters for card payouts
    #   @return [String]
    # @!attribute dob
    #   The sender's date of birth in a YYYY-MM-DD format. Strongly recommended where available. Bank
    #   payouts only; card payouts and regular payments use date_of_birth.
    #   [Optional]
    #   max 10 characters
    #   @return [String]
    # @!attribute address
    #   The sender's address. For card payouts, the sender's residential address.
    #   [Required]
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute identification
    #   The sender's identification. For card payouts, required if the card's issuer_country is one of AR, BR,
    #   CO or PE.
    #   [Optional]
    #   @return [CheckoutSdk::Common::AccountHolderIdentification]
    # @!attribute reference
    #   For card payouts, the unique identifier for the sender, for example a customer number; only
    #   alphanumeric characters are supported. For bank payouts, a unique reference to the underlying
    #   client's customer, a global KYC requirement. For regular payments, the unique reference for the
    #   sender of the payment.
    #   [Required] for card payouts and bank payouts, [Optional] for regular payments
    #   min 5 characters, max 15 characters for card payouts
    #   @return [String]
    # @!attribute reference_type
    #   The type of identifier used as the reference. Card payouts only.
    #   [Required] for card payouts
    #   Enum: "other"
    #   @return [String]
    # @!attribute date_of_birth
    #   The sender's date of birth, in the format YYYY-MM-DD. For card payouts, required for cross-border
    #   money transfers. Card payouts and regular payments; bank payouts use dob.
    #   [Optional]
    #   10 characters for card payouts, max 10 characters for regular payments
    #   @return [String]
    # @!attribute source_of_funds
    #   The source of the funds used to fund the card payout. Card payouts only.
    #   [Required] for card payouts
    #   Enum: "credit" "debit" "prepaid" "deposit_account" "mobile_money_account" "cash"
    #   @return [String] {SourceOfFunds}
    # @!attribute country_of_birth
    #   The sender's country of birth, as a two-letter ISO country code. Card payouts only.
    #   [Optional]
    #   2 characters
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute nationality
    #   The sender's nationality, as a two-letter ISO country code. Card payouts only.
    #   [Optional]
    #   2 characters
    #   @return [String] {CheckoutSdk::Common::Country}
    class IndividualSender < Sender
      attr_accessor :first_name,
                    :middle_name,
                    :last_name,
                    :dob,
                    :address,
                    :identification,
                    :reference,
                    :reference_type,
                    :date_of_birth,
                    :source_of_funds,
                    :country_of_birth,
                    :nationality

      def initialize
        super(CheckoutSdk::Payments::SenderType::INDIVIDUAL)
      end
    end
  end
end
