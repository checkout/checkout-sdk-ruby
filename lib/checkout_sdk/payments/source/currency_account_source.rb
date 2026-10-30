# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # A currency account source, with type currency_account.
    # Used by card payouts, bank payouts and unreferenced refunds.
    #
    # id: the ID of the currency account that will fund the payout or the unreferenced refund. For bank
    # payouts, its holding currency must match the payout's currency.
    # [Required]
    # ^(ca)_(\w{26})$
    # 29 characters
    class CurrencyAccountSource < PayoutSource
      def initialize
        super(PayoutSourceType::CURRENCY_ACCOUNT)
      end
    end
  end
end
