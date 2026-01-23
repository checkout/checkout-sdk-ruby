# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute number
    #   @return [String]
    # @!attribute expiry_month
    #   @return [Integer]
    # @!attribute expiry_year
    #   @return [Integer]
    # @!attribute account_holder
    #   @return [CheckoutSdk::Common::AccountHolder]
    class CardDestination < Destination
      attr_accessor :number,
                    :expiry_month,
                    :expiry_year,
                    :account_holder

      def initialize
        super(CheckoutSdk::Payments::DestinationType::CARD)
      end
    end
  end
end
