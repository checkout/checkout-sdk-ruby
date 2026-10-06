# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The identification of a representative or individual on the Accounts API v2.0 US variants.
    # @!attribute national_id_number
    #   Social Security Number (SSN), or Individual Taxpayer Identification Number (ITIN) for non-US
    #   citizens.
    #   [Required]
    #   ^\d{9}$
    #   9 characters
    #   @return [String]
    # @!attribute document
    #   @deprecated Not defined by the Accounts API: the identification object carries national_id_number only.
    #   @return [Document]
    class Identification
      attr_accessor :national_id_number,
                    :document
    end
  end
end
