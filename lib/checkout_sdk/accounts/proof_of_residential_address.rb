# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Proof of residential address of the representative. Representative documents only
    # (company.representatives[].documents), EEA Sole Trader Full (3.0).
    # @!attribute type
    #   The type of document being used as address verification.
    #   [Required]
    #   @return [String] {ProofOfResidentialAddressType]
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class ProofOfResidentialAddress
      attr_accessor :type,
                    :front
    end
  end
end
