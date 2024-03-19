# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # @!attribute documents
    #   @return [Document]
    # @!attribute company_verification
    #   @return [CompanyVerification]
    # @!attribute tax_verification
    #   @return [TaxVerification]
    class OnboardSubEntityDocuments
      attr_accessor :documents,
                    :company_verification,
                    :tax_verification
    end
  end
end
