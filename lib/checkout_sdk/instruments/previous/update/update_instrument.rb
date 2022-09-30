# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Instruments
      # @!attribute expiry_month
      #   @return [Integer]
      # @!attribute expiry_month
      #   @return [Integer]
      # @!attribute name
      #   @return [String]
      # @!attribute account_holder
      #   @return [CheckoutSdk::Common::AccountHolder]
      # @!attribute customer
      #   @return [CheckoutSdk::Common::CustomerRequest]
      class UpdateInstrument
        attr_accessor :expiry_month,
                      :expiry_year,
                      :name,
                      :account_holder,
                      :customer
      end
    end
  end
end
