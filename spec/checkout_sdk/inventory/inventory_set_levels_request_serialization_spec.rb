# frozen_string_literal: true

RSpec.describe 'InventorySetLevelsRequest serialization' do
  it 'serializes all properties (roundtrip)' do
    request = CheckoutSdk::Inventory::InventorySetLevelsRequest.new
    request.on_hand = 100
    request.safety_stock = 10
    request.reason = 'restock'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

    expect(hash['on_hand']).to eq(100)
    expect(hash['safety_stock']).to eq(10)
    expect(hash['reason']).to eq('restock')
  end

  it 'deserializes the swagger example' do
    json = '{"on_hand":100,"safety_stock":10,"reason":"restock"}'
    parsed = JSON.parse(json, object_class: OpenStruct)

    expect(parsed.on_hand).to eq(100)
    expect(parsed.safety_stock).to eq(10)
    expect(parsed.reason).to eq('restock')
  end
end
