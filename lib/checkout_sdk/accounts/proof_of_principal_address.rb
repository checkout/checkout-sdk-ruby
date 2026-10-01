# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Proof of the company's principal place of business.
    # @!attribute type
    #   The type of document being used as address verification.
    #   [Required]
    #   @return [String] {ProofOfPrincipalAddressType}
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class ProofOfPrincipalAddress
      attr_accessor :type,
                    :front
    end
  end
end
