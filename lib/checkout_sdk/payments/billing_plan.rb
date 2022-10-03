# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute type
    #   @return [String] {BillingPlanType}
    # @!attribute skip_shipping_address
    #   @return [TrueClass, FalseClass]
    # @!attribute immutable_shipping_address
    #   @return [TrueClass, FalseClass]
    class BillingPlan
      attr_accessor :type,
                    :skip_shipping_address,
                    :immutable_shipping_address
    end
  end
end
