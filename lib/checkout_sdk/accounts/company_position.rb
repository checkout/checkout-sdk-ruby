# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The position of a representative within the company (required for the control_person role).
    module CompanyPosition
      CEO = 'ceo'
      CFO = 'cfo'
      COO = 'coo'
      MANAGING_MEMBER = 'managing_member'
      GENERAL_PARTNER = 'general_partner'
      PRESIDENT = 'president'
      VICE_PRESIDENT = 'vice_president'
      TREASURER = 'treasurer'
      OTHER_SENIOR_MANAGEMENT = 'other_senior_management'
      OTHER_EXECUTIVE_OFFICER = 'other_executive_officer'
      OTHER_NON_EXECUTIVE_NON_SENIOR = 'other_non_executive_non_senior'
    end
  end
end
