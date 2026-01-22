# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute first_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    class AccountHolderIndividual < AccountHolder
      attr_accessor :first_name,
                    :last_name

      def initialize
        super(AccountHolderType::INDIVIDUAL)
      end
    end
  end
end
