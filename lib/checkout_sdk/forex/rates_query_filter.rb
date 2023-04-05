# frozen_string_literal: true

module CheckoutSdk
  module Forex
    # @!attribute product
    #   @return [String]
    # @!attribute source
    #   @return [String] {ForexSource}
    # @!attribute currency_pairs
    #   @return [String]
    # @!attribute process_channel_id
    #   @return [String]
    class RatesQueryFilter
      attr_accessor :product,
                    :source,
                    :currency_pairs,
                    :process_channel_id
    end
  end
end
