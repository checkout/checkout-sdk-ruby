# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The type of Direct Debit account on an ACH payment source.
    #
    # `PaymentRequestAchSource` is the only position in the specification declaring
    # this set. Two neighbouring types are deliberately different and must not be
    # substituted:
    #
    # - {CheckoutSdk::Common::AccountType} is savings / **current** / cash, and serves
    #   the bank-account instrument and destination positions. It does not declare
    #   `checking`, so it cannot express a valid ACH source account type.
    # - {CheckoutSdk::Instruments::AchAccountType} is savings / checking, and serves
    #   the stored ACH instrument positions. It does not declare `cash`.
    module AchSourceAccountType
      SAVINGS = 'savings'
      CHECKING = 'checking'
      CASH = 'cash'
    end
  end
end
