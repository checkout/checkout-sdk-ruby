# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The top-level request documents ({OnboardEntity#documents}). The API ignores keys it does not
    # recognise here rather than rejecting them, so a misplaced document is dropped silently. The
    # representative's own documents go on {Representative#documents} ({RepresentativeDocuments}).
    # @!attribute identity_verification
    #   The document to use to confirm the individual's identity.
    #   [Required] for the six sole trader variants of Accounts API v2.0 (EEA, GB and US, Full and Lite), the
    #   only variants that take it at this level. On v3.0 it belongs on the representative.
    #   @return [Document]
    # @!attribute company_verification
    #   The document to use to confirm the company's identity (certified by a power of attorney within the
    #   last 3 months).
    #   [Required] for EEA Company Full (2.0 and 3.0) and GB Company Full (2.0); [Optional] for the other
    #   company variants and the US ISV Seller variants.
    #   @return [CompanyVerification]
    # @!attribute articles_of_association
    #   Memorandum or Articles of Association document.
    #   [Required] for EEA and GB Company Full (3.0); [Optional] for US Company Full (3.0) and the US ISV
    #   Seller variants.
    #   @return [ArticlesOfAssociation]
    # @!attribute bank_verification
    #   A document showing transactions from the last 3 months.
    #   [Required] for EEA Company Full (3.0) and the EEA, GB and US Sole Trader Full (3.0) variants;
    #   [Optional] for GB and US Company Full (3.0) and EEA Company Full and Lite (2.0).
    #   @return [BankVerification]
    # @!attribute shareholder_structure
    #   Shareholder structure chart (including % of shares) certified by a competent authority individual and
    #   dated within the last 3 months.
    #   [Required] for EEA and GB Company Full (3.0); [Optional] for US Company Full (3.0) and US ISV Seller
    #   Company (3.0).
    #   @return [ShareholderStructure]
    # @!attribute proof_of_legality
    #   A regulatory licence document required for the company to operate (when applicable).
    #   [Optional] (EEA, GB and US Company Full (3.0) and the US ISV Seller variants)
    #   @return [ProofOfLegality]
    # @!attribute proof_of_principal_address
    #   Proof of the company's principal place of business.
    #   [Optional] (EEA, GB and US Company Full (3.0) and the US ISV Seller variants)
    #   @return [ProofOfPrincipalAddress]
    # @!attribute additional_document1
    #   Additional space for documents to be provided when requested.
    #   [Optional] (EEA, GB and US Company and Sole Trader Full (3.0); not the US ISV Seller variants)
    #   @return [AdditionalDocument]
    # @!attribute additional_document2
    #   Additional space for documents to be provided when requested.
    #   [Optional] (EEA, GB and US Company and Sole Trader Full (3.0); not the US ISV Seller variants)
    #   @return [AdditionalDocument]
    # @!attribute additional_document3
    #   Additional space for documents to be provided when requested.
    #   [Optional] (EEA, GB and US Company and Sole Trader Full (3.0); not the US ISV Seller variants)
    #   @return [AdditionalDocument]
    # @!attribute tax_verification
    #   IRS-issued Employer Identification Number document used to verify the entity's tax identification.
    #   [Optional] (US Company variants and the US ISV Seller variants only)
    #   @return [TaxVerification]
    # @!attribute financial_verification
    #   Financial statement document. Becomes mandatory depending on the answer provided for
    #   annual_processing_volume.
    #   [Optional] (EEA Company Full and Lite (2.0) only)
    #   @return [FinancialVerification]
    # @!attribute financial_statements
    #   Audited or management-prepared financial statements (when applicable).
    #   [Optional] (US ISV Seller variants only)
    #   @return [FinancialStatements]
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
                    :financial_verification,
                    :financial_statements
    end
  end
end
