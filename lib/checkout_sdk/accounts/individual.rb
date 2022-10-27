# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute first_name
    #   @return [String]
    # @!attribute middle_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute legal_name
    #   @return [String]
    # @!attribute trading_name
    #   @return [String]
    # @!attribute national_tax_id
    #   @return [String]
    # @!attribute registered_address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute date_of_birth
    #   @return [DateOfBirth]
    # @!attribute place_of_birth
    #   @return [PlaceOfBirth]
    # @!attribute identification
    #   @return [Identification]
    class Individual
      attr_accessor :first_name,
                    :middle_name,
                    :last_name,
                    :legal_name,
                    :trading_name,
                    :national_tax_id,
                    :registered_address,
                    :date_of_birth,
                    :place_of_birth,
                    :identification
    end
  end
end
