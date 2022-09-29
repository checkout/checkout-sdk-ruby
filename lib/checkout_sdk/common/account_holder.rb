# frozen_string_literal: true

module CheckoutSdk
  module Common
    # @!attribute type
    #   @return [String] {AccountHolderType}
    # @!attribute first_name
    #   @return [String]
    # @!attribute last_name
    #   @return [String]
    # @!attribute company_name
    #   @return [String]
    # @!attribute tax_id
    #   @return [String]
    # @!attribute date_of_birth
    #   @return [String]
    # @!attribute country_of_birth
    #   @return [Country]
    # @!attribute residential_status
    #   @return [String]
    # @!attribute billing_address
    #   @return [Address]
    # @!attribute phone
    #   @return [Phone]
    # @!attribute identification
    #   @return [AccountHolderIdentification]
    # @!attribute email
    #   @return [String]
    class AccountHolder
      attr_accessor :type,
                    :first_name,
                    :last_name,
                    :company_name,
                    :tax_id,
                    :date_of_birth,
                    :country_of_birth,
                    :residential_status,
                    :billing_address,
                    :phone,
                    :identification,
                    :email
    end
  end
end
