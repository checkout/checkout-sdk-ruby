# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address]
    class CvConnectSource < PaymentSource
      attr_accessor :billing_address

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::CV_CONNECT
      end
    end
  end
end
