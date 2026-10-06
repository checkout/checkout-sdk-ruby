# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The document types accepted as company verification. ARTICLES_OF_ASSOCIATION is accepted on the US
    # Company (2.0) variants only; articles of association sent as their own document use
    # {ArticlesOfAssociationType} instead.
    module CompanyVerificationType
      INCORPORATION_DOCUMENT = 'incorporation_document'
      ARTICLES_OF_ASSOCIATION = 'articles_of_association'
    end
  end
end
