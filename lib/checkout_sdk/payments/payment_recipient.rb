# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute dob
    #   @return [String]
    # @!attribute account_number
    #   @return [String]
    # @!attribute address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute zip
    #   @deprecated Please use {#CheckoutSdk::Common::Address.zip} instead
    #   @return [String]
    # @!attribute first_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute country
    #   @return [String] {CheckoutSdk::Common::Country}
    class PaymentRecipient
      attr_accessor :dob,
                    :account_number,
                    :address,
                    :zip,
                    :first_name,
                    :last_name,
                    :country
    end
  end
end
