# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # A regulatory licence document required for the company to operate (when applicable).
    # @!attribute type
    #   The type of document used for proof of legality.
    #   [Required]
    #   @return [String] {ProofOfLegalityType}
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class ProofOfLegality
      attr_accessor :type,
                    :front
    end
  end
end
