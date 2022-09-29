# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute name
    #   @return [String]
    # @!attribute city
    #   @return [String]
    # @!attribute reference
    #   @return [String]
    class BillingDescriptor
      attr_accessor :name,
                    :city,
                    :reference
    end
  end
end
