# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [FinancialVerificationType]
    # @!attribute front
    #   @return [String]
    class FinancialVerification
      attr_reader :type,
                  :front
    end
  end
end
