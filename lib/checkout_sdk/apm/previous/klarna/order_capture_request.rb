# frozen_string_literal: true

module CheckoutSdk
  module Previous
    module Apm
      module Klarna
        # @!attribute type
        #   @return [CheckoutSdk::Common::PaymentSourceType]
        # @!attribute amount
        #   @return [Integer]
        # @!attribute reference
        #   @return [String]
        # @!attribute metadata
        #   @return [Hash(String=>Object)]
        # @!attribute klarna
        #   @return [Klarna]
        # @!attribute shipping_info
        #   @return [KlarnaShippingInfo]
        # @!attribute shipping_delay
        #   @return [Integer]
        class OrderCaptureRequest
          attr_reader :type
          attr_accessor :amount,
                        :reference,
                        :metadata,
                        :klarna,
                        :shipping_info,
                        :shipping_delay

          def initialize
            @type = CheckoutSdk::Common::PaymentSourceType::KLARNA
          end
        end
      end
    end
  end
end
