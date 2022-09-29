# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute purpose
    #   @return [FilePurpose]
    class FileRequest < AbstractFileRequest
      attr_accessor :purpose
    end
  end
end
