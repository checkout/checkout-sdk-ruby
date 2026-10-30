# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The type of identification used to identify the sender of an Account Funding Transaction on a
    # Payment Setup. Maps swagger `PaymentSetup.account_funding_transaction.sender.identification.type`.
    module AccountFundingTransactionIdentificationType
      # A driving license.
      DRIVING_LICENSE = 'driving_license'
      # A passport.
      PASSPORT = 'passport'
      # A national identity document.
      NATIONAL_ID = 'national_id'
    end
  end
end
