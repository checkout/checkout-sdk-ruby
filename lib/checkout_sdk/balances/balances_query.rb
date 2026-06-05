# frozen_string_literal: true

module CheckoutSdk
  module Balances
    # Query parameters accepted by GET /balances/{id}.
    #
    # @!attribute query
    #   @return [String] Search expression (e.g. "currency:EUR").
    # @!attribute with_currency_account_id
    #   @return [TrueClass, FalseClass] When true, the response includes the
    #     `currency_account_id` on each {CurrencyAccountBalance}.
    #   Serialised as `withCurrencyAccountId`.
    # @!attribute balances_at
    #   @return [String] A UTC datetime (RFC 3339) to retrieve historical
    #     balances at a specific point in time. Must be in the past.
    #   Serialised as `balancesAt`.
    class BalancesQuery
      attr_accessor :query,
                    :with_currency_account_id,
                    :balances_at

      # Returns the params in the camelCase form expected by the API.
      def to_h
        {
          query: query,
          withCurrencyAccountId: with_currency_account_id,
          balancesAt: balances_at
        }.compact
      end
    end
  end
end
