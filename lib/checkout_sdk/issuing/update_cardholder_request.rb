# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for PATCH /issuing/cardholders/{cardholderId}.
    # Maps swagger `update-cardholder-request`.
    #
    # @!attribute first_name
    #   @return [String]
    # @!attribute middle_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute date_of_birth
    #   @return [String] ISO-8601 date.
    # @!attribute phone_number
    #   @return [IssuingPhoneNumber]
    # @!attribute email
    #   @return [String] Email address (rfc6530). Max 254 characters.
    # @!attribute billing_address
    #   @return [IssuingAddress]
    # @!attribute residency_address
    #   @return [IssuingAddress]
    class UpdateCardholderRequest
      attr_accessor :first_name, :middle_name, :last_name, :date_of_birth,
                    :phone_number, :email, :billing_address, :residency_address
    end
  end
end
