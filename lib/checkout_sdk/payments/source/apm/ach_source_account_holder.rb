# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The account holder's details on an ACH payment source.
    #
    # Maps swagger `AccountHolderAch` exactly. This is deliberately not
    # {CheckoutSdk::Common::AccountHolder}, which carries 16 properties against the
    # seven declared here.
    #
    # Two nested types are reused rather than redeclared, because their property sets
    # match: `billing_address` uses {CheckoutSdk::Common::Address}, whose six
    # properties are exactly the `Address` schema this position references. For
    # `identification` the reused type carries one property, date_of_expiry, that this
    # position does not declare - noted on the attribute below.
    #
    # @!attribute type
    #   @return [String] {CheckoutSdk::Common::AccountHolderType} The type of account
    #     holder. [Required] individual, corporate or government.
    # @!attribute first_name
    #   @return [String] The account holder's first name. [Required]
    # @!attribute last_name
    #   @return [String] The account holder's last name. [Required]
    # @!attribute company_name
    #   @return [String] The account holder's company name. [Optional]
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address] The account holder's billing address.
    #     [Optional]
    # @!attribute date_of_birth
    #   @return [String] The account holder's date of birth. [Optional]
    # @!attribute identification
    #   @return [CheckoutSdk::Common::AccountHolderIdentification] The account
    #     holder's identification. [Optional] This position declares only type,
    #     issuing_country and number - do not set date_of_expiry.
    class AchSourceAccountHolder
      attr_accessor :type,
                    :first_name,
                    :last_name,
                    :company_name,
                    :billing_address,
                    :date_of_birth,
                    :identification
    end
  end
end
