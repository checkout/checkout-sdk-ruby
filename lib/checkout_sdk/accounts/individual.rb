# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The top-level individual of the Accounts API v2.0 sole trader variants. On v3.0 a sole trader is
    # onboarded as a {Company} with one {Representative}.
    # @!attribute first_name
    #   The individual's first name.
    #   [Required]
    #   min 2 characters, max 50 characters
    #   @return [String]
    # @!attribute middle_name
    #   The individual's middle name. Required if it appears in official documents.
    #   [Optional]
    #   min 2 characters, max 50 characters
    #   @return [String]
    # @!attribute last_name
    #   The individual's last name.
    #   [Required]
    #   min 2 characters, max 50 characters
    #   @return [String]
    # @!attribute legal_name
    #   @deprecated Not defined by the Accounts API for an individual; legal_name exists on the company only.
    #   @return [String]
    # @!attribute trading_name
    #   The trading name of the sub-entity, also referred to as 'doing business as'.
    #   [Required]
    #   min 2 characters, max 300 characters
    #   @return [String]
    # @!attribute national_tax_id
    #   @deprecated Not defined by any Accounts API schema; the API does not read it.
    #   @return [String]
    # @!attribute registered_address
    #   The registered address of the sole trader's business.
    #   [Required]
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute date_of_birth
    #   The date of birth of the person according to the Gregorian calendar.
    #   [Required], except on GB Sole Trader Lite (2.0) where it is [Optional].
    #   @return [DateOfBirth]
    # @!attribute place_of_birth
    #   The place of birth of the person.
    #   [Required] for EEA Sole Trader Full and Lite (2.0); not part of the other v2.0 variants.
    #   @return [PlaceOfBirth]
    # @!attribute identification
    #   The individual's identification. US Sole Trader (2.0) only.
    #   [Required] for US Sole Trader Full (2.0); [Optional] for US Sole Trader Lite (2.0).
    #   @return [Identification]
    # @!attribute financial_details
    #   Seller financial questions. US Sole Trader (2.0) only.
    #   [Required] for US Sole Trader Full (2.0); [Optional] for US Sole Trader Lite (2.0).
    #   @return [EntityFinancialDetails]
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
                    :identification,
                    :financial_details
    end
  end
end
