# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The terms of service the sub-entity agreed to (Accounts API v3.0, SaaS onboarding).
    # @!attribute date
    #   @return [String] Date and time the terms were agreed (RFC 3339 / ISO 8601).
    # @!attribute ip_address
    #   @return [String] IP address (IPv4 or IPv6) of the person at the time they agreed.
    # @!attribute name
    #   @return [String] First and last name of the person who agreed to the terms.
    # @!attribute email
    #   @return [String] Email address of the person who agreed to the terms.
    # @!attribute version
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
