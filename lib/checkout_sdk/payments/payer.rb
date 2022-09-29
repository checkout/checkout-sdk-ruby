# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # @!attribute name
    #   @return [String]
    # @!attribute email
    #   @return [String]
    # @!attribute document
    #   @return [String]
    class Payer
      attr_accessor :name,
                    :email,
                    :document
    end
  end
end
