# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The account holder details of a Bacs Direct Debit instrument being stored.
    #
    # The store shape declares three properties only. The update and retrieve shapes
    # additionally declare company_name and type - see
    # {UpdateBacsAccountHolder}.
    #
    # @!attribute first_name
    #   @return [String] The first name of the account holder. [Required]
    # @!attribute last_name
    #   @return [String] The last name of the account holder. [Required]
    # @!attribute billing_address
    #   @return [CreateBacsBillingAddress] The billing address of the account
    #     holder. [Required]
    class CreateBacsAccountHolder
      attr_accessor :first_name,
                    :last_name,
                    :billing_address
    end
  end
end
