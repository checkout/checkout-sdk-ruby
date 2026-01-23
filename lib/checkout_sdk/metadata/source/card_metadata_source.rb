# frozen_string_literal: true

module CheckoutSdk
  module Metadata
    # @!attribute number
    #   @return [String]
    class CardMetadataSource < MetadataSource
      attr_accessor :number

      def initialize
        super(MetadataSourceType::CARD)
      end
    end
  end
end
