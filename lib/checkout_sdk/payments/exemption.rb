# frozen_string_literal: true

module CheckoutSdk
  module Payments
    module Exemption
      LOW_VALUE = 'low_value'
      SECURE_CORPORATE_PAYMENT = 'secure_corporate_payment'
      TRUSTED_LISTING = 'trusted_listing'
      TRANSACTION_RISK_ASSESSMENT = 'transaction_risk_assessment'
      THREE_DS_OUTAGE = '3ds_outage'
      SCA_DELEGATION = 'sca_delegation'
      OUT_OF_SCA_SCOPE = 'out_of_sca_scope'
      OTHER = 'other'
      LOW_RISK_PROGRAM = 'low_risk_program'
    end
  end
end
