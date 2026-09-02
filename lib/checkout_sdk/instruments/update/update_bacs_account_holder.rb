# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The account holder details of a Bacs Direct Debit instrument being updated.
    #
    # Unlike {CreateBacsAccountHolder} this shape also declares company_name and
    # type.
    #
    # @!attribute first_name
    #   @return [String] The first name of the account holder. [Optional]
    # @!attribute last_name
    #   @return [String] The last name of the account holder. [Optional]
    # @!attribute company_name
    #   @return [String] The legal name of a registered company that holds the
    #     account. [Optional] max 50 characters.
    # @!attribute billing_address
    #   @return [UpdateBacsBillingAddress] The billing address of the account
    #     holder. [Optional]
    # @!attribute type
    #   @return [String] {InstrumentAccountHolderType} The type of account holder.
    #     [Optional]
    class UpdateBacsAccountHolder
      attr_accessor :first_name,
                    :last_name,
                    :company_name,
                    :billing_address,
                    :type
    end
  end
end
