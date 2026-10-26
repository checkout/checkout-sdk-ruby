# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Sender identification details of an Account Funding Transaction on a Payment Setup.
    # Maps swagger `PaymentSetup.account_funding_transaction.sender.identification`.
    #
    # @!attribute type
    #   The type of identification used to identify the sender.
    #   [Optional]
    #   @return [String] One of {AccountFundingTransactionIdentificationType}.
    # @!attribute number
    #   The identification number.
    #   [Optional]
    #   @return [String]
    # @!attribute issuing_country
    #   The two-letter ISO country code of the country that issued the identification.
    #   [Optional]
    #   @return [String] {CheckoutSdk::Common::Country}
    class AccountFundingTransactionIdentification
      attr_accessor :type,
                    :number,
                    :issuing_country
    end
  end
end
