# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute enabled
    #   @return [TrueClass, FalseClass]
    # @!attribute purpose
    #   @return [String] {AccountFundingTransactionPurpose}
    # @!attribute sender
    #   @return [AccountFundingTransactionSender]
    # @!attribute recipient
    #   @return [AccountFundingTransactionRecipient]
    class PaymentSetupAccountFundingTransaction
      attr_accessor :enabled,
                    :purpose,
                    :sender,
                    :recipient
    end
  end
end
