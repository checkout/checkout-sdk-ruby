# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The personal details of a company representative (company.representatives[].individual), Accounts
    # API v3.0.
    # @!attribute first_name
    #   The representative's first name.
    #   [Required]
    #   min 2 characters, max 50 characters
    #   @return [String]
    # @!attribute middle_name
    #   The representative's middle name. Required if it appears in official documents.
    #   [Optional]
    #   min 2 characters, max 50 characters
    #   @return [String]
    # @!attribute last_name
    #   The representative's last name.
    #   [Required]
    #   min 2 characters, max 50 characters
    #   @return [String]
    # @!attribute date_of_birth
    #   The date of birth of the person according to the Gregorian calendar.
    #   [Required]
    #   @return [DateOfBirth]
    # @!attribute place_of_birth
    #   The place of birth of the person.
    #   [Required]
    #   @return [PlaceOfBirth]
    # @!attribute citizenships
    #   The list of citizenships or legal statuses for the representative.
    #   [Required] for the US ISV Seller variants only; not part of the other v3.0 schemas, leave unset for
    #   them.
    #   @return [Array(Citizenship)]
    # @!attribute national_id_type
    #   The classification of the national identification number provided.
    #   [Required] for the US ISV Seller variants only; not part of the other v3.0 schemas, leave unset for
    #   them.
    #   @return [String] {NationalIdType}
    # @!attribute national_id_number
    #   The representative's national identification number.
    #   [Required] for the US ISV Seller variants; [Optional] for the other v3.0 variants.
    #   The format depends on the variant:
    #     US ISV Seller: the number for the national_id_type given. ^[a-zA-Z0-9\-]+$, min 5 characters, max
    #     16 characters.
    #     Other v3.0 variants: a Social Security Number (SSN) or Individual Taxpayer Identification Number
    #     (ITIN), US residents only. ^\d{9}$, 9 characters.
    #   @return [String]
    # @!attribute email_address
    #   The representative's personal email address.
    #   [Required] for the US ISV Seller variants; [Optional] for the other v3.0 variants.
    #   Format: email
    #   @return [String]
    # @!attribute phone
    #   The representative's phone number.
    #   [Required] for the US ISV Seller variants; [Optional] for the other v3.0 variants.
    #   @return [Phone]
    # @!attribute address
    #   The representative's address.
    #   [Required]
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
