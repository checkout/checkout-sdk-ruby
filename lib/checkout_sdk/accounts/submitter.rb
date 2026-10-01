# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Not defined by any Accounts API onboarding schema.
    # @deprecated Not part of any Accounts API onboarding schema; the API does not read it.
    # @!attribute ip_address
    #   @deprecated Not defined by any Accounts API onboarding schema.
    #   @return [String]
    class Submitter
      attr_accessor :ip_address
    end
  end
end
