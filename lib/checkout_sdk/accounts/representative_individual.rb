# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The personal details of a company representative ("person of interest"), as required by the
    # Accounts API v3.0 schema.
    # @!attribute first_name
    #   @return [String]
    # @!attribute middle_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute date_of_birth
    #   @return [DateOfBirth]
    # @!attribute place_of_birth
    #   @return [PlaceOfBirth]
    # @!attribute citizenships
    #   @return [Array(Citizenship)]
    # @!attribute national_id_type
    #   @return [String] {NationalIdType}
    # @!attribute national_id_number
    #   @return [String]
    # @!attribute email_address
    #   @return [String]
    # @!attribute phone
    #   @return [Phone]
    # @!attribute address
    #   @return [CheckoutSdk::Common::Address]
    class RepresentativeIndividual
      attr_accessor :first_name,
                    :middle_name,
                    :last_name,
                    :date_of_birth,
                    :place_of_birth,
                    :citizenships,
                    :national_id_type,
                    :national_id_number,
                    :email_address,
                    :phone,
                    :address
    end
  end
end
