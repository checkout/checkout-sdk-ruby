# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute id
    #   @return [String]
    # @!attribute first_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute identification
    #   @return [Identification]
    # @!attribute phone
    #   @return [Phone]
    # @!attribute date_of_birth
    #   @return [DateOfBirth]
    # @!attribute place_of_birth
    #   @return [PlaceOfBirth]
    # @!attribute roles
    #   @return [Array(String)]
    # @!attribute documents
    #   @return [OnboardSubEntityDocuments]
    class Representative
      attr_accessor :id,
                    :first_name,
                    :last_name,
                    :address,
                    :identification,
                    :phone,
                    :date_of_birth,
                    :place_of_birth,
                    :roles,
                    :documents
    end
  end
end
