# frozen_string_literal: true

module CheckoutSdk
  module Customers
    # @!attribute email
    #   @return [String]
    # @!attribute name
    #   @return [String]
    # @!attribute phone
    #   @return [CheckoutSdk::Common::Phone]
    # @!attribute metadata
    #   @return [Hash{String => Object}]
    # @!attribute default
    #   @return [String]
    # @!attribute instruments
    #   @return [Array(String)]
    class CustomerRequest
      attr_accessor :email,
                    :name,
                    :phone,
                    :metadata,
                    :default,
                    :instruments
    end
  end
end
