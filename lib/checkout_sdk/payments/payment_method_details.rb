# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute display_name
    #   @return [String]
    # @!attribute type
    #   @return [String]
    # @!attribute network
    #   @return [String]
    class PaymentMethodDetails
      attr_accessor :display_name,
                    :type,
                    :network
    end
  end
end
