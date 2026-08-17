# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # The document type accepted by the legal document that verifies a bank account when
    # creating a payment instrument.
    #
    # Deliberately separate from DocumentType, which lists identity documents (passport,
    # national identity card, driving license). The API keeps the bank account document type
    # as its own enum whose only accepted value is bank_statement, so offering it alongside
    # the identity documents would suggest it is valid where the API rejects it, and vice
    # versa.
    module InstrumentDocumentType
      BANK_STATEMENT = 'bank_statement'
    end
  end
end
