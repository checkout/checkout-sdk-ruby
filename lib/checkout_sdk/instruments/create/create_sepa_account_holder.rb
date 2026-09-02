# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The account holder details of a SEPA instrument being stored.
    #
    # @!attribute first_name
    #   @return [String] The first name of the account holder. [Required]
    # @!attribute last_name
    #   @return [String] The last name of the account holder. [Required]
    # @!attribute billing_address
    #   @return [CreateSepaBillingAddress] The billing address of the account
    #     holder. [Required]
    # @!attribute company_name
    #   @return [String] The legal name of a registered company that holds the
    #     account. [Optional] max 50 characters.
    # @!attribute type
    #   @return [String] {InstrumentAccountHolderType} The type of account holder.
    #     [Optional]
    class CreateSepaAccountHolder
      attr_accessor :first_name,
                    :last_name,
                    :billing_address,
                    :company_name,
                    :type
    end
  end
end
