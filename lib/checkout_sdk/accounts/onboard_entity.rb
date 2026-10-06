# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The request body of POST /accounts/entities and PUT /accounts/entities/{id}. Which attributes are
    # required depends on the onboarding variant.
    # @!attribute reference
    #   A unique reference you can later use to identify the sub-entity.
    #   [Required]
    #   min 1 character, max 50 characters
    #   @return [String]
    # @!attribute is_draft
    #   Whether the sub-entity should remain in draft on PUT, skipping due diligence checks. POST always
    #   creates the entity in draft.
    #   [Optional]
    #   @return [Boolean]
    # @!attribute profile
    #   Information about the profile of the sub-entity.
    #   [Required]
    #   @return [Profile]
    # @!attribute contact_details
    #   Contact details of this sub-entity.
    #   [Required], except on EEA Company Full (3.0) where it is [Optional].
    #   @return [ContactDetails]
    # @!attribute company
    #   Information about the company represented by the sub-entity.
    #   [Required] for every company and v3.0 sole trader variant.
    #   @return [Company]
    # @!attribute processing_details
    #   Information about the sub-entity's expected processing.
    #   [Required] for every v3.0 variant.
    #   @return [ProcessingDetails]
    # @!attribute individual
    #   Information about the individual represented by the sub-entity. Accounts API v2.0 sole traders only.
    #   [Required] for the v2.0 sole trader variants.
    #   @deprecated Not used by the Accounts API v3.0 schema, where a sole trader is onboarded as a company with a
    #     representative.
    #   @return [Individual]
    # @!attribute documents
    #   The top-level documents used to support the verification of the sub-entity's details.
    #   [Required] on the EEA, GB and US Company and Sole Trader Full (3.0) variants, EEA Company Full (2.0)
    #   and EEA Sole Trader Full (2.0); [Optional] otherwise.
    #   @return [OnboardSubEntityDocuments]
    # @!attribute additional_info
    #   @deprecated Not defined by any Accounts API schema; the API does not read it.
    #   @return [AdditionalInfo]
    # @!attribute seller_category
    #   The identifier of a seller category set up for your platform. Seller categories define the pricing,
    #   capabilities and risk profile applied to sub-entities.
    #   [Required] for the US ISV Seller variants only.
    #   @return [String] Identifier of a seller category configured on the platform
    # @!attribute agreed_terms
    #   Details of the person who agreed to the terms and conditions on behalf of the sub-entity.
    #   [Required] for the US ISV Seller variants only.
    #   @return [AgreedTerms] Details of the person who agreed to the terms and
    # @!attribute submitter
    #   @deprecated Not defined by any Accounts API schema; the API does not read it.
    #   @return [Submitter] Captures evidence of the end-user's consent to onboarding.
    class OnboardEntity
      attr_accessor :reference,
                    :is_draft,
                    :profile,
                    :contact_details,
                    :company,
                    :processing_details,
                    :individual,
                    :documents,
                    :additional_info,
                    :seller_category,
                    :agreed_terms,
                    :submitter
    end
  end
end
