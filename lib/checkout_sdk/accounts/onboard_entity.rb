# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute reference
    #   @return [String]
    # @!attribute is_draft
    #   @return [Boolean]
    # @!attribute profile
    #   @return [Profile]
    # @!attribute contact_details
    #   @return [ContactDetails]
    # @!attribute company
    #   @return [Company]
    # @!attribute processing_details
    #   @return [ProcessingDetails]
    # @!attribute individual
    #   @return [Individual]
    # @!attribute documents
    #   @return [OnboardSubEntityDocuments]
    # @!attribute additional_info
    #   @return [AdditionalInfo]
    class OnboardEntity
      attr_accessor :reference,
                    :is_draft,
                    :profile,
                    :contact_details,
                    :company,
                    :processing_details,
                    :individual,
                    :documents,
                    :additional_info
    end
  end
end
