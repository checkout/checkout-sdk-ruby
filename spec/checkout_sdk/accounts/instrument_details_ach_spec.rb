# frozen_string_literal: true

RSpec.describe CheckoutSdk::Accounts::InstrumentDetailsAch do
  it 'is an InstrumentDetails' do
    expect(described_class.new).to be_a(CheckoutSdk::Accounts::InstrumentDetails)
  end

  it 'serializes all three fields to their swagger keys' do
    details = described_class.new
    details.account_number = '12345100'
    details.routing_number = '026009593'
    details.account_type = 'savings'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(details)

    expect(hash['account_number']).to eq('12345100')
    expect(hash['routing_number']).to eq('026009593')
    expect(hash['account_type']).to eq('savings')
  end
end
