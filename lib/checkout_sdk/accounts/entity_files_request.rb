# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Request for POST /entities/{entityId}/files.
    # @!attribute purpose
    #   The purpose of the file upload: the onboarding document the file is for.
    #   [Required]
    #   @return [String] {FilePurpose}
    class EntityFilesRequest
      attr_accessor :purpose
    end
  end
end
