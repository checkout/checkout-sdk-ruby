# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute reference
    #   @return [String]
    # @!attribute contact_details
    #   @return [ContactDetails]
    # @!attribute profile
    #   @return [Profile]
    # @!attribute company
    #   @return [Company]
    # @!attribute individual
    #   @return [Individual]
    # @!attribute documents
    #   @return [OnboardSubEntityDocuments]
    class OnboardEntity
      attr_accessor :reference,
                    :contact_details,
                    :profile,
                    :company,
                    :individual,
                    :documents
    end
  end
end
