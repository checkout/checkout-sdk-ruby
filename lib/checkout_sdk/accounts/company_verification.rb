# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The document to use to confirm the company's identity (certified by a power of attorney within the
    # last 3 months).
    # @!attribute type
    #   The type of document used for company verification. articles_of_association is accepted on the US
    #   Company (2.0) variants only.
    #   [Required]
    #   @return [String] {CompanyVerificationType}
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class CompanyVerification
      attr_accessor :type,
                    :front
    end
  end
end
