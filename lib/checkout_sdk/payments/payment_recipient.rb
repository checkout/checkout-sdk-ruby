# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute dob
    #   @return [String]
    # @!attribute account_number
    #   @return [String]
    # @!attribute zip
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
                    :zip,
                    :first_name,
                    :last_name,
                    :country
    end
  end
end
