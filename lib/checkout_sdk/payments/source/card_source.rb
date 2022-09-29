# frozen_string_literal: true

module CheckoutSdk
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
    #   @return [String] {CheckoutSdk::Common::Address}
    # @!attribute phone
    #   @return [String] {CheckoutSdk::Common::Phone}
    class CardSource < PaymentRequestSource
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
        super CheckoutSdk::Common::PaymentSourceType::CARD
      end
    end
  end
end
