# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute purpose
    #   @return [FilePurpose]
    # @!attribute file
    #   @return [String]
    class FileRequest
      attr_accessor :purpose,
                    :file
    end
  end
end
