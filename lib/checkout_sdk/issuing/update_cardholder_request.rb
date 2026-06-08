# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for PATCH /issuing/cardholders/{cardholderId}.
    #
    # @!attribute first_name
    #   @return [String]
    # @!attribute middle_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute date_of_birth
    #   @return [String]
    # @!attribute phone_number
    #   @return [Object] Phone object per swagger.
    # @!attribute email
    #   @return [String]
    # @!attribute billing_address
    #   @return [Object]
    # @!attribute residency_address
    #   @return [Object]
    # @!attribute document
    #   @return [Object] IdentificationDocument.
    class UpdateCardholderRequest
      attr_accessor :first_name, :middle_name, :last_name, :date_of_birth,
                    :phone_number, :email, :billing_address, :residency_address,
                    :document
    end
  end
end
