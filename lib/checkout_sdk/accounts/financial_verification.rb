# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Financial statement document. Becomes mandatory depending on the answer provided for
    # annual_processing_volume; the sub-entity's status changes to requirements_due when it is needed.
    # @!attribute type
    #   The type of the file.
    #   [Required]
    #   @return [FinancialVerificationType]
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class FinancialVerification
      attr_accessor :type,
                    :front
    end
  end
end
