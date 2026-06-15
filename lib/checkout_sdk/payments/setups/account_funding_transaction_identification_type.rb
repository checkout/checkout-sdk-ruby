# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Identification document type used by the sender of an Account Funding Transaction
    # on a Payment Setup.
    module AccountFundingTransactionIdentificationType
      DRIVING_LICENSE = 'driving_license'
      PASSPORT = 'passport'
      NATIONAL_ID = 'national_id'
      TAX_ID = 'tax_id'
      OTHER = 'other'
    end
  end
end
