# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The purpose of an onboarding document upload ({AccountsClient#upload_file} and
    # {AccountsClient#upload_entity_file}): the values PlatformsFileUpload defines.
    module FilePurpose
      ADDITIONAL_DOCUMENT = 'additional_document'
      ARTICLES_OF_ASSOCIATION = 'articles_of_association'
      BANK_VERIFICATION = 'bank_verification'
      CERTIFIED_AUTHORISED_SIGNATORY = 'certified_authorised_signatory'
      COMPANY_OWNERSHIP = 'company_ownership'
      COMPANY_VERIFICATION = 'company_verification'
      FINANCIAL_VERIFICATION = 'financial_verification'
      IDENTITY_VERIFICATION = 'identity_verification'
      PROOF_OF_LEGALITY = 'proof_of_legality'
      PROOF_OF_PRINCIPAL_ADDRESS = 'proof_of_principal_address'
      SHAREHOLDER_STRUCTURE = 'shareholder_structure'
      TAX_VERIFICATION = 'tax_verification'
      PROOF_OF_RESIDENTIAL_ADDRESS = 'proof_of_residential_address'
      PROOF_OF_REGISTRATION = 'proof_of_registration'
    end
  end
end
