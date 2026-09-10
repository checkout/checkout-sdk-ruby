# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The billing descriptor for payment.
    #
    # @!attribute name
    #   @return [String] A dynamic description of the payment. Max length: 25.
    # @!attribute city
    #   @return [String] The city from which the payment was made. Max length: 13.
    # @!attribute reference
    #   @return [String] The reference shown on the statement. Max length: 50.
    class PaymentSetupBillingDescriptor
      attr_accessor :name,
                    :city,
                    :reference
    end
  end
end
