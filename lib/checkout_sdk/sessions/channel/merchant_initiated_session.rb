# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute request_type
    #   @return [RequestType]
    class MerchantInitiatedSession < ChannelData
      attr_accessor :request_type

      def initialize
        super(ChannelDataType::MERCHANT_INITIATED)
      end
    end
  end
end
