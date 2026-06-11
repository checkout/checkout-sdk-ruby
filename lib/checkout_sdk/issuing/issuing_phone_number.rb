# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Phone number block used in Issuing requests (e.g. cardholder updates).
    # Matches swagger `IssuingPhoneNumber`.
    #
    # @!attribute country_code
    #   @return [String] E.164 country dial code (e.g. "+1").
    # @!attribute number
    #   @return [String] Local subscriber number.
    class IssuingPhoneNumber
      attr_accessor :country_code, :number
    end
  end
end
