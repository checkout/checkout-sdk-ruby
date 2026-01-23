# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute company_name
    #   @return [String]
    class AccountHolderCorporate < AccountHolder
      attr_accessor :company_name

      def initialize
        super(AccountHolderType::CORPORATE)
      end
    end
  end
end
