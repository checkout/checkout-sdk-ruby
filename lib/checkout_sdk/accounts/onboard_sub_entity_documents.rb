# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute identity_verification
    #   @return [EntityIdentificationDocument]
    # @!attribute company_verification
    #   @return [CompanyVerification]
    # @!attribute articles_of_association
    #   @return [ArticlesOfAssociationType]
    # @!attribute bank_verification
    #   @return [BankVerification]
    # @!attribute shareholder_structure
    #   @return [ShareholderStructure]
    # @!attribute proof_of_legality
    #   @return [ProofOfLegality]
    # @!attribute proof_of_principal_address
    #   @return [ProofOfPrincipalAddress]
    # @!attribute additional_document1
    #   @return [AdditionalDocument]
    # @!attribute additional_document2
    #   @return [AdditionalDocument]
    # @!attribute additional_document3
    #   @return [AdditionalDocument]
    # @!attribute tax_verification
    #   @return [TaxVerification]
    # @!attribute financial_verification
    #   @return [FinancialVerification]
    class OnboardSubEntityDocuments
      attr_accessor :identity_verification,
                    :company_verification,
                    :articles_of_association,
                    :bank_verification,
                    :shareholder_structure,
                    :proof_of_legality,
                    :proof_of_principal_address,
                    :additional_document1,
                    :additional_document2,
                    :additional_document3,
                    :tax_verification,
                    :financial_verification
    end
  end
end
