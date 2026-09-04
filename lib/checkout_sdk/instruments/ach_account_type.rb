# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The type of Direct Debit account on an ACH instrument.
    #
    # The ACH instrument schemas declare savings and checking only. The ACH payment
    # source additionally declares cash - see {CheckoutSdk::Common::AccountType}.
    module AchAccountType
      SAVINGS = 'savings'
      CHECKING = 'checking'
    end
  end
end
