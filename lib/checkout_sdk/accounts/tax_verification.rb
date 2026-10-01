# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # IRS-issued Employer Identification Number document used to verify the entity's tax identification
    # (US variants).
    # @!attribute type
    #   The type of IRS-issued document used for tax verification.
    #   [Required]
    #   @return [String] {TaxVerificationType}
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class TaxVerification
      attr_accessor :type,
                    :front
    end
  end
end
