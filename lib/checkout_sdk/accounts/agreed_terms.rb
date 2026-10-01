# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Evidence of consent to Checkout.com onboarding: the person who agreed to the terms and conditions
    # (US ISV Seller variants).
    # @!attribute date
    #   Date and time the terms were agreed, in RFC 3339 or ISO 8601 format.
    #   [Required]
    #   Format: date-time
    #   @return [String] Date and time the terms were agreed (RFC 3339 / ISO 8601).
    # @!attribute ip_address
    #   IP address (IPv4 or IPv6) of the person at the time they agreed the terms.
    #   [Required]
    #   @return [String] IP address (IPv4 or IPv6) of the person at the time they agreed.
    # @!attribute name
    #   First and last name of the person who agreed to the terms.
    #   [Required]
    #   @return [String] First and last name of the person who agreed to the terms.
    # @!attribute email
    #   Email address of the person who agreed to the terms.
    #   [Required]
    #   Format: email
    #   @return [String] Email address of the person who agreed to the terms.
    # @!attribute version
    #   Identifier of the terms version that was agreed.
    #   [Required]
    #   @return [String] Identifier of the terms version that was agreed.
    class AgreedTerms
      attr_accessor :date,
                    :ip_address,
                    :name,
                    :email,
                    :version
    end
  end
end
