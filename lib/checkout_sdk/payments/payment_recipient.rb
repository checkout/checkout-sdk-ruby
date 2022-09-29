# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute dob
    #   @return [String]
    # @!attribute account_number
    #   @return [String]
    # @!attribute zip
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    class PaymentRecipient
      attr_accessor :dob,
                    :account_number,
                    :zip,
                    :last_name
    end
  end
end
