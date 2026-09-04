# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Payment billing descriptor on a Swish payment source.
    #
    # @!attribute name
    #   @return [String] A description for the payment, which displays on the
    #     customer's statement. [Required] max 120 characters.
    class SwishBillingDescriptor
      attr_accessor :name
    end
  end
end
