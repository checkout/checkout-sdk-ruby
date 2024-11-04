# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute mobile_number
    #   @return [String]
    class BizumSource < PaymentSource
      attr_accessor :mobile_number

      def initialize
        super CheckoutSdk::Common::PaymentSourceType::BIZUM
      end
    end
  end
end
