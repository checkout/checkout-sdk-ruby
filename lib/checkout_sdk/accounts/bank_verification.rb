# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # A document showing transactions from the last 3 months.
    # @!attribute type
    #   The type of document being used as bank verification.
    #   [Required]
    #   @return [BankVerificationType]
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class BankVerification
      attr_accessor :type,
                    :front
    end
  end
end
