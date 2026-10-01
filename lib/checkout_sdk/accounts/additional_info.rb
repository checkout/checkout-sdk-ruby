# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Not defined by any Accounts API schema.
    # @deprecated Not part of any Accounts API schema; the API does not read it.
    # @!attribute field1
    #   @deprecated Not defined by any Accounts API schema.
    #   @return [String]
    # @!attribute field2
    #   @deprecated Not defined by any Accounts API schema.
    #   @return [String]
    # @!attribute field3
    #   @deprecated Not defined by any Accounts API schema.
    #   @return [String]
    class AdditionalInfo
      attr_accessor :field1,
                    :field2,
                    :field3
    end
  end
end
