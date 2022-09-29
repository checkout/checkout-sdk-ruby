# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # @!attribute type
    #   @return [String] {CompletionInfoType}
    class CompletionInfo
      attr_reader :type

      protected

      # @abstract
      # @param [String] type {CompletionInfoType}
      def initialize(type)
        @type = type
      end
    end
  end
end
