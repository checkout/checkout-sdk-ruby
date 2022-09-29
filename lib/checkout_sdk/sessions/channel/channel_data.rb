# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute channel
    #   @return [String] {ChannelDataType}
    class ChannelData
      attr_reader :channel

      protected

      # @abstract
      # @param [String] channel {ChannelDataType}
      def initialize(channel)
        @channel = channel
      end
    end
  end
end
