# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Proof of the sole trader's registration, for example an extract from a trade register.
    # Representative documents only (company.representatives[].documents), EEA Sole Trader Full (3.0).
    # @!attribute type
    #   The type of document being used as proof of registration.
    #   [Required]
    #   @return [String] {ProofOfRegistrationType}
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class ProofOfRegistration
      attr_accessor :type,
                    :front
    end
  end
end
