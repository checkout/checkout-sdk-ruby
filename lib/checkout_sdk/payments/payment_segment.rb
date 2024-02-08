# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute brand
    #   @return [String]
    # @!attribute business_category
    #   @return [String]
    # @!attribute market
    #   @return [String]
    class PaymentSegment
      attr_accessor :brand,
                    :business_category,
                    :market
    end
  end
end
