# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Audited or management-prepared financial statements (when applicable). US ISV Seller variants only.
    # Not the same document as {FinancialVerification}, whose type is the singular financial_statement.
    # @!attribute type
    #   The type of document.
    #   [Required]
    #   @return [String] {FinancialStatementsType}
    # @!attribute front
    #   The ID of the front side of the document as represented within Checkout.com systems.
    #   [Required]
    #   ^file_[a-z2-7]{26}$
    #   31 characters
    #   @return [String]
    class FinancialStatements
      attr_accessor :type,
                    :front
    end
  end
end
