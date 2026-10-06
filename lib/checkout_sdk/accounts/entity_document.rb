# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Not defined by any Accounts API onboarding schema. Referenced only by the deprecated {Company#document}
    # and {EntityFinancialDocuments}.
    # @deprecated Not part of any Accounts API onboarding schema.
    # @!attribute type
    #   @deprecated Not defined by any Accounts API onboarding schema.
    #   @return [String]
    # @!attribute file_id
    #   @deprecated Not defined by any Accounts API onboarding schema.
    #   @return [String]
    class EntityDocument
      attr_accessor :type,
                    :file_id
    end
  end
end
