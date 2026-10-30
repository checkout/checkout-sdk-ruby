# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The source of a card payout, bank payout or unreferenced refund.
    #
    # @!attribute type
    #   The payout source type. Set by each subclass.
    #   [Required]
    #   @return [String] {PayoutSourceType}
    # @!attribute id
    #   The identifier of the source. See {CurrencyAccountSource} and {EntitySource} for the format.
    #   [Required]
    #   @return [String]
    # @!attribute amount
    #   The amount of the source.
    #   [Optional]
    #   @deprecated Not in the request schema of any payout or unreferenced refund source; still returned in
    #     PayoutDetails (source.amount). Retained for backwards compatibility and will be removed in the next
    #     major version. There is no replacement.
    #   @return [Integer]
    class PayoutSource
      attr_reader :type
      attr_accessor :id,
                    :amount

      protected

      # @abstract
      # @param [String] type {PayoutSourceType}
      def initialize(type)
        @type = type
      end
    end
  end
end
