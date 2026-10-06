# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Information about the company represented by the sub-entity: on every company and v3.0 sole trader
    # variant, and as the controlling company of a {Representative} (where only legal_name, trading_name
    # and registered_address apply).
    # @!attribute business_registration_number
    #   The sub-entity's business registration number: a Commercial Registration or Ministry of Commerce
    #   certificate number, or an equivalent registration number.
    #   [Required] for the Full variants and US ISV Seller Company (3.0); [Optional] for the Lite (2.0)
    #   variants. Not part of the sole trader variants.
    #   The format depends on the variant:
    #     EEA: min 2 characters, max 39 characters; a SIRET number for sub-entities based in France.
    #     GB (3.0): a Companies House number, 8 characters, matching one of the three alternatives of the
    #     spec's pattern, ^(A|B|C)$:
    #     A: ((AC|CE|CS|FC|FE|GE|GS|IC|LP|NC|NF|NI|NL|NO|NP|OC|OE|PC|R0|RC|SA|SC|SE|SF|SG|SI|SL|SO|SR|SZ|ZC|\d{2})\d{6})
    #     B: ((IP|SP|RS)[A-Z\d]{6})
    #     C: (SL\d{5}[\dA])
    #     GB (2.0) accepts the same pattern case-insensitively.
    #     US: an Employer Identification Number (EIN), ^[0-9]{9}$, 9 characters; US ISV Seller Company (3.0)
    #     also accepts the hyphenated form, ^[0-9]{2}-?[0-9]{7}$, min 9 characters, max 11.
    #   @return [String]
    # @!attribute business_type
    #   The legal type of the company ({BusinessType} values). Must be individual_or_sole_proprietorship for
    #   the sole trader variants.
    #   [Required], except on EEA and US Company Lite (2.0) where it is [Optional]. Not part of GB Company
    #   Full and Lite (2.0).
    #   @return [String] {BusinessType}
    # @!attribute legal_name
    #   The legal name of the sub-entity.
    #   [Required] for every company variant and the controlling company; not part of the sole trader
    #   variants.
    #   min 2 characters, max 300 characters
    #   @return [String]
    # @!attribute trading_name
    #   The trading name of the sub-entity, also referred to as 'doing business as'.
    #   [Required]
    #   min 2 characters, max 300 characters
    #   @return [String]
    # @!attribute additional_trading_names
    #   The collection of additional trading names for the sub-entity.
    #   [Optional] (US ISV Seller variants only)
    #   @return [Array(String)]
    # @!attribute is_registered_company
    #   Whether the sub-entity is a registered legal entity. Must be false for US ISV Seller Sole Trader
    #   (3.0).
    #   [Required] for US ISV Seller Sole Trader (3.0); not part of the other variants.
    #   @return [Boolean]
    # @!attribute date_of_incorporation
    #   The date the company was incorporated, or the date the sole trader started trading.
    #   [Required] for every v3.0 variant; [Optional] for EEA, GB and US Company Full (2.0).
    #   @return [DateOfIncorporation]
    # @!attribute regulatory_licence_number
    #   The regulatory licence number of the company.
    #   [Optional] (EEA Company Full (3.0) only)
    #   ^[a-zA-Z0-9\-]+$
    #   min 4 characters, max 32 characters
    #   @return [String]
    # @!attribute principal_address
    #   The primary location where business is performed.
    #   [Required] for every company and v3.0 sole trader variant.
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute registered_address
    #   The registered address of the company.
    #   [Required] for every company variant and the controlling company; not part of the sole trader
    #   variants.
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute representatives
    #   Information about the representatives of this company.
    #   [Required]
    #   min 1 item; max 1 item for the sole trader variants (the individual themselves, with roles [ubo]),
    #   max 5 on v2.0, max 25 on EEA, GB and US Company Full (3.0), no maximum on US ISV Seller Company
    #   (3.0)
    #   @return [Array(Representative)]
    # @!attribute document
    #   @deprecated Not defined by any Accounts API company schema; the API does not read it.
    #   @return [EntityDocument]
    # @!attribute financial_details
    #   Seller financial questions.
    #   [Required] for EEA and US Company Full (2.0); [Optional] for EEA and US Company Lite (2.0). Not part
    #   of the other variants.
    #   @return [EntityFinancialDetails]
    class Company
      attr_accessor :business_registration_number,
                    :business_type,
                    :legal_name,
                    :trading_name,
                    :additional_trading_names,
                    :is_registered_company,
                    :date_of_incorporation,
                    :regulatory_licence_number,
                    :principal_address,
                    :registered_address,
                    :representatives,
                    :document,
                    :financial_details
    end
  end
end
