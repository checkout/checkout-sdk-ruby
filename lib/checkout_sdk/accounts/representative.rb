# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # A representative of the sub-entity. One class covers every shape the Accounts API defines: the v3.0
    # person of interest (individual, roles, company_position, ownership_percentage, documents), the v3.0
    # controlling company of EEA and GB Company Full (company, ownership_percentage), and the v2.0 company
    # representative (the flat person fields, roles, documents and, on the US variants, identification).
    # @!attribute id
    #   The representative's id.
    #   [Optional]
    #   ^rep_[a-z0-9]{26}$
    #   30 characters
    #   @return [String]
    # @!attribute individual
    #   Information about the individual representing the sub-entity.
    #   [Required] for every v3.0 person of interest.
    #   @return [RepresentativeIndividual] Personal details (Accounts API v3.0).
    # @!attribute company_position
    #   The position of the representative within the company (required for the control_person role).
    #   [Optional] (EEA, GB and US Company Full (3.0) and US ISV Seller Company (3.0))
    #   @return [String] {CompanyPosition}
    # @!attribute ownership_percentage
    #   The percentage ownership of the UBO or controlling company (required when over 25%).
    #   [Optional]
    #   min 25, max 100 on the EEA, GB and US Company Full (3.0) variants; min 0, max 100 on the US ISV
    #   Seller variants
    #   @return [Integer]
    # @!attribute roles
    #   The individual's roles within the company ({EntityRoles} values). For sole traders, must be ubo only.
    #   [Required] for every variant except EEA and US Company Lite (2.0), where it is [Optional].
    #   @return [Array(String)] {EntityRoles}
    # @!attribute documents
    #   Verification documents for the individual representative. On the EEA, GB and US Company Full (3.0)
    #   and Sole Trader Full (3.0) variants the API validates this object strictly and rejects any key the
    #   variant does not define; the US ISV Seller (3.0) and v2.0 variants do not declare it strict. See
    #   {RepresentativeDocuments} for the keys each variant accepts.
    #   [Required] for the EEA, GB and US Sole Trader Full (3.0) variants and EEA Company Full (2.0);
    #   [Optional] otherwise.
    #   @return [RepresentativeDocuments]
    # @!attribute company
    #   The controlling company, when the representative is a company rather than an individual.
    #   [Required] for a controlling company representative (EEA and GB Company Full (3.0) only).
    #   The API reads only three attributes here, all [Required]: legal_name, trading_name and
    #   registered_address. Leave the other {Company} attributes unset.
    #   @return [Company]
    # @!attribute first_name
    #   The representative's first name. Accounts API v2.0 only.
    #   [Required] (v2.0)
    #   min 2 characters, max 50 characters
    #   @deprecated Not used by the Accounts API v3.0 schema; use individual.
    #   @return [String]
    # @!attribute middle_name
    #   The representative's middle name. Required if it appears in official documents. Accounts API v2.0
    #   only.
    #   [Optional]
    #   min 2 characters, max 50 characters
    #   @deprecated Not used by the Accounts API v3.0 schema; use individual.
    #   @return [String]
    # @!attribute last_name
    #   The representative's last name. Accounts API v2.0 only.
    #   [Required] (v2.0)
    #   min 2 characters, max 50 characters
    #   @deprecated Not used by the Accounts API v3.0 schema; use individual.
    #   @return [String]
    # @!attribute address
    #   The representative's address. Accounts API v2.0 only.
    #   [Required] (v2.0)
    #   @deprecated Not used by the Accounts API v3.0 schema; use individual.
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute identification
    #   The representative's identification. Accounts API v2.0 US Company variants only.
    #   [Required] for US Company Full (2.0); [Optional] for US Company Lite (2.0).
    #   @deprecated Not used by the Accounts API v3.0 schema.
    #   @return [Identification]
    # @!attribute phone
    #   The representative's phone number. Accounts API v2.0 only.
    #   [Optional]
    #   @deprecated Not used by the Accounts API v3.0 schema; use individual.
    #   @return [Phone]
    # @!attribute date_of_birth
    #   The date of birth of the person according to the Gregorian calendar. Accounts API v2.0 only.
    #   [Required] for the v2.0 Full variants; [Optional] for the v2.0 Lite variants.
    #   @deprecated Not used by the Accounts API v3.0 schema; use individual.
    #   @return [DateOfBirth]
    # @!attribute place_of_birth
    #   The place of birth of the person. Accounts API v2.0 only.
    #   [Required] for EEA Company Full (2.0); [Optional] for EEA Company Lite (2.0). Not part of the other
    #   v2.0 variants.
    #   @deprecated Not used by the Accounts API v3.0 schema; use individual.
    #   @return [PlaceOfBirth]
    class Representative
      attr_accessor :id,
                    :individual,
                    :company_position,
                    :ownership_percentage,
                    :roles,
                    :documents,
                    :company,
                    # v2.0 only — deprecated; use `individual` for v3.0
                    :first_name,
                    :middle_name,
                    :last_name,
                    :address,
                    :identification,
                    :phone,
                    :date_of_birth,
                    :place_of_birth
    end
  end
end
