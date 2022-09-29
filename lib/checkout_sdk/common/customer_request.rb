# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute id
    #   @return [String]
    # @!attribute email
    #   @return [String]
    # @!attribute name
    #   @return [String]
    # @!attribute tax_number
    #   @return [String]
    # @!attribute phone
    #   @return [Phone]
    # @!attribute default
    #   @return [TrueClass, FalseClass]
    class CustomerRequest
      attr_accessor :id,
                    :email,
                    :name,
                    :tax_number,
                    :phone,
                    :default
    end
  end
end
