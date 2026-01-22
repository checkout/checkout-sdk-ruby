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
      # @!attribute first_name
      #   @return [String]
      # @!attribute last_name
      #   @return [String]
      # @!attribute name
      #   @return [String]
      # @!attribute billing_address
      #   @return [CheckoutSdk::Common::Address]
      # @!attribute phone
      #   @return [CheckoutSdk::Common::Phone]
      class CardDestination < Destination
        attr_accessor :number,
                      :expiry_month,
                      :expiry_year,
                      :first_name,
                      :last_name,
                      :name,
                      :billing_address,
                      :phone

        def initialize
          super(CheckoutSdk::Payments::DestinationType::CARD)
        end
      end
    end
  end
end
