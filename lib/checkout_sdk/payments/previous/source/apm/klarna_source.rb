# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute authorization_token
      #   @return [String]
      # @!attribute locale
      #   @return [String]
      # @!attribute purchase_country
      #   @return [CheckoutSdk::Common::Country]
      # @!attribute auto_capture
      #   @return [TrueClass, FalseClass]
      # @!attribute billing_address
      #   @return [Hash(String=>Object)]
      # @!attribute shipping_address
      #   @return [Hash(String=>Object)]
      # @!attribute tax_amount
      #   @return [Integer]
      # @!attribute products
      #   @return [Array(Hash(String=>Object))]
      # @!attribute customer
      #   @return [Hash(String=>Object)]
      # @!attribute merchant_reference1
      #   @return [String]
      # @!attribute merchant_reference2
      #   @return [String]
      # @!attribute merchant_data
      #   @return [String]
      # @!attribute attachment
      #   @return [Hash(String=>String)]
      # @!attribute custom_payment_method_ids
      #   @return [Array(Hash(String=>String))]
      class KlarnaSource < PaymentSource
        attr_accessor :authorization_token,
                      :locale,
                      :purchase_country,
                      :auto_capture,
                      :billing_address,
                      :shipping_address,
                      :tax_amount,
                      :products,
                      :customer,
                      :merchant_reference1,
                      :merchant_reference2,
                      :merchant_data,
                      :attachment,
                      :custom_payment_method_ids

        def initialize
          super CheckoutSdk::Common::PaymentSourceType::KLARNA
        end
      end
    end
  end
end
