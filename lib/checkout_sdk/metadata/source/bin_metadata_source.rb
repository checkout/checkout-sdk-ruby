# frozen_string_literal: true

module CheckoutSdk
  module Metadata
    # @!attribute bin
    #   @return [String]
    class BinMetadataSource < MetadataSource
      attr_accessor :bin

      def initialize
        super MetadataSourceType::BIN
      end
    end
  end
end
