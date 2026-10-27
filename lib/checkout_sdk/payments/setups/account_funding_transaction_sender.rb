# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute first_name
    #   @deprecated Not part of the Sender schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [String]
    # @!attribute last_name
    #   @deprecated Not part of the Sender schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [String]
    # @!attribute date_of_birth
    #   @return [String] Format: YYYY-MM-DD
    # @!attribute country_of_birth
    #   @deprecated Not part of the Sender schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute nationality
    #   @deprecated Not part of the Sender schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute address
    #   @deprecated Not part of the Sender schema of the Payment Setups account funding transaction; the
    #     API ignores it on requests. There is no replacement. Will be removed in the next major version.
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute reference
    #   The unique reference for the sender of the payment.
    #   [Optional]
    #   @return [String]
    # @!attribute identification
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
