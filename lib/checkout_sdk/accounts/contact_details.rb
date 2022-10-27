# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute phone
    #   @return [Phone]
    # @!attribute email_addresses
    #   @return [EntityEmailAddresses]
    class ContactDetails
      attr_accessor :phone,
                    :email_addresses
    end
  end
end
