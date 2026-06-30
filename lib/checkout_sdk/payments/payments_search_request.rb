# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Request body for POST /payments/search.
    #
    # @!attribute query
    #   @return [String] The query string (max 1024 chars).
    # @!attribute limit
    #   @return [Integer] Results per page (1-1000, default 10).
    # @!attribute from_
    #   @return [String] ISO 8601 UTC start. Required if `to` is set.
    #     Serialised as `from`.
    # @!attribute to
    #   @return [String] ISO 8601 UTC end. Required if `from` is set.
    class PaymentsSearchRequest
      attr_accessor :query, :limit, :from_, :to
    end
  end
end
