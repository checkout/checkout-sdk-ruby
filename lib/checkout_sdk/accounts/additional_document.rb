# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Additional space for documents to be provided when requested. Carries a file ID only; the API defines
    # no document type for it.
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class AdditionalDocument
      attr_accessor :front
    end
  end
end
