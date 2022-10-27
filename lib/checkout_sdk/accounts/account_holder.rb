# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute type
    #   @return [String] {CheckoutSdk::Common::AccountHolderType}
    # @!attribute tax_id
    #   @return [String]
    # @!attribute date_of_birth
    #   @return [DateOfBirth]
    # @!attribute country_of_birth
    #   @return [String] {CheckoutSdk::Common::Country}
    # @!attribute residential_status
    #   @return [String]
    # @!attribute billing_address
    #   @return [CheckoutSdk::Common::Address]
    # @!attribute phone
    #   @return [Phone]
    # @!attribute identification
    #   @return [CheckoutSdk::Common::AccountHolderIdentification]
    # @!attribute email
    #   @return [String]
    class AccountHolder
      attr_accessor :type,
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
