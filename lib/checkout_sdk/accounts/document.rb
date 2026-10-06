# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The document to use to confirm an individual's identity (identity_verification): on a representative
    # ({RepresentativeDocuments}), or at the top level of the v2.0 sole trader variants.
    # @!attribute type
    #   The type of document used for identity verification.
    #   [Required]
    #   @return [String] {DocumentType}
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    # @!attribute back
    #   The ID of the back side of the document as represented within Checkout.com systems.
    #   [Optional]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class Document
      attr_accessor :type,
                    :front,
                    :back
    end
  end
end
