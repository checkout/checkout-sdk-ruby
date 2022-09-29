# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute id
    #   @return [String]
    # @!attribute default
    #   @return [TrueClass, FalseClass]
    class UpdateCustomerRequest
      attr_accessor :id,
                    :default
    end
  end
end
