# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # ACH bank-account instrument details. Maps swagger `PlatformsInstrumentDetailsAch`.
    # All three attributes are required.
    #
    # @!attribute account_number
    #   @return [String] The alphanumeric value that identifies the account.
    # @!attribute routing_number
    #   @return [String] The 9-digit American Bankers Association (ABA) routing number that
    #     identifies the financial institution.
    # @!attribute account_type
    #   @return [String] The type of bank account. One of `savings`, `checking`.
    class InstrumentDetailsAch < InstrumentDetails
      attr_accessor :account_number,
                    :routing_number,
                    :account_type
    end
  end
end
