# frozen_string_literal: true

module CheckoutSdk
  module Balances
    # A single currency account's balance details (swagger: CurrencyAccountBalance).
    #
    # @!attribute currency_account_id
    #   @return [String] The unique identifier of the currency account (sub-account).
    #     Returned only when the request is made with `withCurrencyAccountId=true`.
    # @!attribute descriptor
    #   @return [String]
    # @!attribute holding_currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute balances_as_of
    #   @return [String] UTC datetime (RFC 3339) reflecting when balance values were fetched.
    # @!attribute balances
    #   @return [BalanceValues]
    class CurrencyAccountBalance
      attr_accessor :currency_account_id,
                    :descriptor,
                    :holding_currency,
                    :balances_as_of,
                    :balances
    end
  end
end
