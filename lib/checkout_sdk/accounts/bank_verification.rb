# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [BankVerificationType]
    # @!attribute front
    #   @return [String]
    class BankVerification
      attr_accessor :type,
                    :front
    end
  end
end
