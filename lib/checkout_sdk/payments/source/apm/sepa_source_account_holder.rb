# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The account holder's personal information on a SEPA payment source.
    #
    # Maps the `account_holder` object of swagger `PaymentRequestSEPAV4Source`
    # exactly. This is deliberately not {CheckoutSdk::Common::AccountHolder}, which
    # carries 16 properties against the five declared here.
    #
    # @!attribute billing_address
    #   @return [SepaSourceBillingAddress] The account holder's billing address.
    #     [Required] All five of its properties are required.
    # @!attribute first_name
    #   @return [String] The account holder's first name. [Optional]
    #     max 50 characters.
    # @!attribute last_name
    #   @return [String] The account holder's last name. [Optional]
    #     max 50 characters.
    # @!attribute company_name
    #   @return [String] The account holder's company name. [Optional]
    #     max 50 characters.
    # @!attribute type
    #   @return [String] {InstrumentAccountHolderType} The type of account holder.
    #     [Optional] Send this lowercase (individual / corporate). The specification
    #     declares it capitalized at this one position, but every other
    #     account-holder-type position declares it lowercase and every other
    #     Checkout.com SDK sends lowercase. Pending confirmation from the API owners.
    class SepaSourceAccountHolder
      attr_accessor :billing_address,
                    :first_name,
                    :last_name,
                    :company_name,
                    :type
    end
  end
end
