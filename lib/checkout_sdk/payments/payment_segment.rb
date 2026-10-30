# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The dimension details about business segment for payment request. At least one dimension required.
    #
    # @!attribute brand
    #   The brand of business segment.
    #   [Optional]
    #   max 50 characters
    #   @return [String]
    # @!attribute business_category
    #   The category of business segment.
    #   [Optional]
    #   max 50 characters
    #   @return [String]
    # @!attribute market
    #   The market of business segment.
    #   [Optional]
    #   max 50 characters
    #   @return [String]
    class PaymentSegment
      attr_accessor :brand,
                    :business_category,
                    :market
    end
  end
end
