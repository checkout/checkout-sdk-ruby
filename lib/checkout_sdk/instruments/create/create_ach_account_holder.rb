# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The account holder details of an ACH instrument being stored.
    #
    # The specification lists all four properties in the schema's required array,
    # while the individual field descriptions make them conditional on type
    # ("Required for individual account holder type" / "Required for corporate
    # account holder type"). The two readings contradict each other; send the pair
    # that matches your type value.
    #
    # @!attribute first_name
    #   @return [String] First name. Required for individual account holder type.
    # @!attribute last_name
    #   @return [String] Last name. Required for individual account holder type.
    # @!attribute company_name
    #   @return [String] Company name. Required for corporate account holder type.
    # @!attribute type
    #   @return [String] {InstrumentAccountHolderType} Account holder type.
    #     [Required]
    class CreateAchAccountHolder
      attr_accessor :first_name,
                    :last_name,
                    :company_name,
                    :type
    end
  end
end
