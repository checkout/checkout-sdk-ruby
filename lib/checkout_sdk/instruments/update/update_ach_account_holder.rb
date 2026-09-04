# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The account holder details of an ACH instrument being updated.
    #
    # account_holder is itself optional, but the specification lists all four of its
    # properties in the required array while the field descriptions make them
    # conditional on type. The two readings contradict each other; send the pair that
    # matches your type value. This shape declares no billing_address at all.
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
    class UpdateAchAccountHolder
      attr_accessor :first_name,
                    :last_name,
                    :company_name,
                    :type
    end
  end
end
