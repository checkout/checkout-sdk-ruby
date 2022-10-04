# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Payments
      # @!attribute number
      #   @return [String]
      # @!attribute expiry_month
      #   @return [Integer]
      # @!attribute expiry_year
      #   @return [Integer]
      # @!attribute name
      #   @return [String]
      # @!attribute cvv
      #   @return [String]
      # @!attribute stored
      #   @return [TrueClass, FalseClass]
      # @!attribute store_for_future_use
      #   @return [TrueClass, FalseClass]
      # @!attribute billing_address
      #   @return [CheckoutSdk::Common::Address]
      # @!attribute phone
      #   @return [CheckoutSdk::Common::Phone]
      class DLocalSource < PaymentSource
        attr_accessor :number,
                      :expiry_month,
                      :expiry_year,
                      :name,
                      :cvv,
                      :stored,
                      :store_for_future_use,
                      :billing_address,
                      :phone

        def initialize
          super CheckoutSdk::Common::PaymentSourceType::D_LOCAL
        end
      end
    end
  end
end
