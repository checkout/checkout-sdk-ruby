# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Not defined by any Accounts API schema: financial_details carries the three amounts and the currency
    # only.
    # @deprecated Not part of any Accounts API schema; the API does not read it.
    # @!attribute bank_statement
    #   @deprecated Not defined by any Accounts API schema.
    #   @return [EntityDocument]
    # @!attribute financial_statement
    #   @deprecated Not defined by any Accounts API schema.
    #   @return [EntityDocument]
    class EntityFinancialDocuments
      attr_accessor :bank_statement,
                    :financial_statement
    end
  end
end
