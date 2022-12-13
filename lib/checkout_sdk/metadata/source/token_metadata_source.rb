# frozen_string_literal: true

module CheckoutSdk
  module Metadata
    # @!attribute token
    #   @return [String]
    class TokenMetadataSource < MetadataSource
      attr_accessor :token

      def initialize
        super MetadataSourceType::TOKEN
      end
    end
  end
end
