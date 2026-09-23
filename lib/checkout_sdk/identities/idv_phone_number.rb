# frozen_string_literal: true

module CheckoutSdk
  module Identities
    # The applicant's mobile phone number, if sharing the attempt URL via SMS.
    #
    # Named IdvPhoneNumber rather than PhoneNumber because
    # {CheckoutSdk::Issuing::IssuingPhoneNumber} already exists for a different shape, and the two
    # must not be confused.
    #
    # @!attribute country_code
    #   The international phone country code. This is a dialling prefix, not an ISO country code.
    #   [Required]
    #   ^\+(\d+)$
    #   Example: +33
    #   @return [String]
    # @!attribute number
    #   The applicant's mobile number, without the country code.
    #   [Required]
    #   ^\d{1,14}$
    #   Example: 5555550102
    #   @return [String]
    class IdvPhoneNumber
      attr_accessor :country_code, :number
    end
  end
end
