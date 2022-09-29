# frozen_string_literal: true

module CheckoutSdk
  module Forex
    # @!attribute source_currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute source_amount
    #   @return [Integer]
    # @!attribute destination_currency
    #   @return [String] {CheckoutSdk::Common::Currency}
    # @!attribute destination_amount
    #   @return [Integer]
    # @!attribute process_channel_id
    #   @return [String]
    class QuoteRequest
      attr_accessor :source_currency,
                    :source_amount,
                    :destination_currency,
                    :destination_amount,
                    :process_channel_id
    end
  end
end
