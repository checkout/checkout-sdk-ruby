# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Identification document attached to a cardholder. Matches swagger
    # `IdentificationDocument`. `type` and `front_document_id` are required.
    #
    # @!attribute type
    #   @return [String] Document type (e.g. "passport"). [Required]
    # @!attribute front_document_id
    #   @return [String] File id of the front-side scan. [Required]
    # @!attribute back_document_id
    #   @return [String] File id of the back-side scan (when applicable).
    class IdentificationDocument
      attr_accessor :type, :front_document_id, :back_document_id
    end
  end
end
