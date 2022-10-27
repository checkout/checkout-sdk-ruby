# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute bank_statement
    #   @return [EntityDocument]
    # @!attribute financial_statement
    #   @return [EntityDocument]
    class EntityFinancialDocuments
      attr_accessor :bank_statement,
                    :financial_statement
    end
  end
end
