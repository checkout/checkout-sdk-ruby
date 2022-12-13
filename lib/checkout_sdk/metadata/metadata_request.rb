# frozen_string_literal: true

module CheckoutSdk
  module Metadata
    # @!attribute source
    #   @return [MetadataSource]
    # @!attribute format
    #   @return [String] {Format}
    class MetadataRequest
      attr_accessor :source,
                    :format
    end
  end
end
