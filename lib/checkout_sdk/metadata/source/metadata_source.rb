# frozen_string_literal: true

module CheckoutSdk
  module Metadata
    # @!attribute type
    #   @return [String] {MetadataSourceType}
    class MetadataSource
      attr_reader :type

      protected

      # @abstract
      # @param [String] type {MetadataSourceType}
      def initialize(type)
        @type = type
      end
    end
  end
end
