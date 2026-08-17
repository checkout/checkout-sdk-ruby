# frozen_string_literal: true

RSpec.describe CheckoutSdk::Accounts::InstrumentDocumentType do
  it 'exposes bank_statement for instrument documents' do
    expect(described_class::BANK_STATEMENT).to eq 'bank_statement'
  end

  it 'is the only accepted instrument document type' do
    # The spec declares a single-value enum here, so anything else is a caller error rather
    # than a value we forgot to add.
    values = described_class.constants.map { |c| described_class.const_get(c) }
    expect(values).to eq ['bank_statement']
  end

  it 'keeps bank_statement out of the identity document type' do
    # bank_statement belongs to the instrument document enum, not the identity one. The API
    # keeps them separate, and this is what stops the two being merged the next time someone
    # reports the value as missing from DocumentType.
    identity = CheckoutSdk::Accounts::DocumentType
    values = identity.constants.map { |c| identity.const_get(c) }
    expect(values).not_to include 'bank_statement'
  end
end
