# frozen_string_literal: true

RSpec.describe 'InventoryAdjustmentRequest serialization' do
  it 'serializes all properties (roundtrip)' do
    request = CheckoutSdk::Inventory::InventoryAdjustmentRequest.new
    request.variant_id = 'var_1'
    request.delta = -3
    request.reason = 'damaged in transit'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

    expect(hash['variant_id']).to eq('var_1')
    expect(hash['delta']).to eq(-3)
    expect(hash['reason']).to eq('damaged in transit')
  end

  it 'deserializes the swagger example' do
    json = '{"variant_id":"var_1","delta":-3,"reason":"damaged in transit"}'
    parsed = JSON.parse(json, object_class: OpenStruct)

    expect(parsed.variant_id).to eq('var_1')
    expect(parsed.delta).to eq(-3)
    expect(parsed.reason).to eq('damaged in transit')
  end
end
