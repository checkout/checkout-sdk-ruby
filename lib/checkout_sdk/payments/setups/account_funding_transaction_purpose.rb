# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Enum of allowed `purpose` values on a PaymentSetup AccountFundingTransaction.
    # See https://api-reference.checkout.com (PaymentSetupAccountFundingTransaction.purpose).
    module AccountFundingTransactionPurpose
      DONATIONS = 'donations'
      EDUCATION = 'education'
      EMERGENCY_NEED = 'emergency_need'
      EXPATRIATION = 'expatriation'
      FAMILY_SUPPORT = 'family_support'
      FINANCIAL_SERVICES = 'financial_services'
      GIFTS = 'gifts'
      INCOME = 'income'
      INSURANCE = 'insurance'
      INVESTMENT = 'investment'
      IT_SERVICES = 'it_services'
      LEISURE = 'leisure'
      LOAN_PAYMENT = 'loan_payment'
      MEDICAL_TREATMENT = 'medical_treatment'
      OTHER = 'other'
      PENSION = 'pension'
      ROYALTIES = 'royalties'
      SAVINGS = 'savings'
      TRAVEL_AND_TOURISM = 'travel_and_tourism'
    end
  end
end
