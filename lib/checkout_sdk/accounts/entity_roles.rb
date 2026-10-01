# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # A role a representative holds within the company. For sole traders, the only accepted role is UBO.
    module EntityRoles
      UBO = 'ubo'
      LEGAL_REPRESENTATIVE = 'legal_representative'
      AUTHORISED_SIGNATORY = 'authorised_signatory'
      DIRECTOR = 'director'
      CONTROL_PERSON = 'control_person'
    end
  end
end
