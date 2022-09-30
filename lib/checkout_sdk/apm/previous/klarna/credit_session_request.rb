# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Apm
      # @!attribute purchase_country
      #   @return [String] {CheckoutSdk::Common::Country}
      # @!attribute currency
      #   @return [String] {CheckoutSdk::Common::Currency}
      # @!attribute locale
      #   @return [String]
      # @!attribute amount
      #   @return [Integer]
      # @!attribute tax_amount
      #   @return [Integer]
      # @!attribute products
      #   @return [Array(KlarnaProduct)]
      class CreditSessionRequest
        attr_accessor :purchase_country,
                      :currency,
                      :locale,
                      :amount,
                      :tax_amount,
                      :products
      end
    end
  end
end
