# frozen_string_literal: true

RSpec.describe CheckoutSdk::Payments::VoidRequest do
  it 'serializes amount when set' do
    request = described_class.new
    request.amount = 500
    request.reference = 'partial-void'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

    expect(hash['amount']).to eq(500)
    expect(hash['reference']).to eq('partial-void')
  end

  it 'omits amount from the serialized body when not set' do
    request = described_class.new
    request.reference = 'full-void'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

    expect(hash).not_to have_key('amount')
    expect(hash.to_json).not_to include('amount')
    expect(hash['reference']).to eq('full-void')
  end
end
