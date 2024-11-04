# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute phone
    #   @return [Phone]
    # @!attribute email_addresses
    #   @return [EntityEmailAddresses]
    # @!attribute invitee
    #   @return [Invitee]
    class ContactDetails
      attr_accessor :phone,
                    :email_addresses,
                    :invitee
    end
  end
end
