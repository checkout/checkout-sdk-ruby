# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The classification of a representative's national identification number (US ISV Seller variants).
    module NationalIdType
      SSN = 'ssn'
      ITIN = 'itin'
      PASSPORT = 'passport'
      DRIVING_LICENSE = 'driving_license'
      NATIONAL_ID_CARD = 'national_id_card'
      RESIDENCE_PERMIT = 'residence_permit'
      OTHER = 'other'
    end
  end
end
