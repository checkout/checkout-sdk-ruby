# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Account funding transaction sender details on a Payment Setup.
    # Maps swagger `PaymentSetup.account_funding_transaction.sender`.
    #
    # @!attribute first_name
    #   The sender's first name.
    #   [Optional]
    #   @deprecated Not part of the Sender schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [String]
    # @!attribute last_name
    #   The sender's last name.
    #   [Optional]
    #   @deprecated Not part of the Sender schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [String]
    # @!attribute date_of_birth
    #   Date of birth of the sender (yyyy-mm-dd).
    #   [Optional]
    #   Format: date
    #   @return [String]
    # @!attribute country_of_birth
    #   The sender's country of birth, as an ISO 3166-1 alpha-2 code.
    #   [Optional]
    #   @deprecated Not part of the Sender schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute nationality
    #   The sender's nationality, as an ISO 3166-1 alpha-2 code.
    #   [Optional]
    #   @deprecated Not part of the Sender schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute address
    #   The sender's address.
    #   [Optional]
    #   @deprecated Not part of the Sender schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute reference
    #   The unique reference for the sender of the payment.
    #   [Optional]
    #   @return [String]
    # @!attribute identification
    #   Sender identification details.
    #   [Optional]
    #   @return [AccountFundingTransactionIdentification]
    class AccountFundingTransactionSender
      attr_accessor :first_name,
                    :last_name,
                    :date_of_birth,
                    :country_of_birth,
                    :nationality,
                    :address,
                    :reference,
                    :identification
    end
  end
end
