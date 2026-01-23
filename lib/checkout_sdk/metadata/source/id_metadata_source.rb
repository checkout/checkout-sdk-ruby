# frozen_string_literal: true

module CheckoutSdk
  module Metadata
    # @!attribute id
    #   @return [String]
    class IdMetadataSource < MetadataSource
      attr_accessor :id

      def initialize
        super(MetadataSourceType::ID)
      end
    end
  end
end
