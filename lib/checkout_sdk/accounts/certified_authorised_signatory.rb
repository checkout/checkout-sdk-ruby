# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Certified authorised signatory document. Required when the legal representative or other role owner
    # is not registered on the certificate of incorporation. Representative documents only
    # (company.representatives[].documents), EEA, GB and US Company Full (3.0) and US ISV Seller Company
    # (3.0).
    # @!attribute type
    #   The type of document.
    #   [Required]
    #   @return [String] {CertifiedAuthorisedSignatoryType]
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class CertifiedAuthorisedSignatory
      attr_accessor :type,
                    :front
    end
  end
end
