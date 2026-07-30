# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [FinancialStatementsType]
    # @!attribute front
    #   @return [String]
    class FinancialStatements
      attr_accessor :type,
                    :front
    end
  end
end
