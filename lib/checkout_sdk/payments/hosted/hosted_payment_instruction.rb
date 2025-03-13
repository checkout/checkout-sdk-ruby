# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute purpose
    #   @return [String] {PaymentPurposeType}
    class HostedPaymentInstruction
      attr_accessor :purpose
    end
  end
end
