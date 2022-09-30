# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Apm
      # @!attribute name
      #   @return [String]
      # @!attribute quantity
      #   @return [Integer]
      # @!attribute unit_price
      #   @return [Integer]
      # @!attribute tax_rate
      #   @return [Integer]
      # @!attribute total_amount
      #   @return [Integer]
      # @!attribute total_tax_amount
      #   @return [Integer]
      class KlarnaProduct
        attr_accessor :name,
                      :quantity,
                      :unit_price,
                      :tax_rate,
                      :total_amount,
                      :total_tax_amount
      end
    end
  end
end
