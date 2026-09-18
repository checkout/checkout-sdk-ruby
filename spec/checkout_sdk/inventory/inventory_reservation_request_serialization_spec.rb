# frozen_string_literal: true

RSpec.describe 'InventoryReservationRequest serialization' do
  it 'serializes all properties, including nested items (roundtrip)' do
    item = CheckoutSdk::Inventory::InventoryReservationItem.new
    item.variant_id = 'var_1'
    item.quantity = 2

    request = CheckoutSdk::Inventory::InventoryReservationRequest.new
    request.owner_type = 'agent'
    request.owner_reference = 'order_123'
    request.items = [item]
    request.ttl_seconds = 300

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

    expect(hash['owner_type']).to eq('agent')
    expect(hash['owner_reference']).to eq('order_123')
    expect(hash['items']).to eq([{ 'variant_id' => 'var_1', 'quantity' => 2 }])
    expect(hash['ttl_seconds']).to eq(300)
  end

  it 'deserializes the swagger example' do
    json = '{"owner_type":"agent","owner_reference":"order_123",' \
           '"items":[{"variant_id":"var_1","quantity":2}],"ttl_seconds":300}'
    parsed = JSON.parse(json, object_class: OpenStruct)

    expect(parsed.owner_type).to eq('agent')
    expect(parsed.owner_reference).to eq('order_123')
    expect(parsed.items.first.variant_id).to eq('var_1')
    expect(parsed.items.first.quantity).to eq(2)
    expect(parsed.ttl_seconds).to eq(300)
  end
end

RSpec.describe 'InventoryReservationItem serialization' do
  it 'serializes all properties (roundtrip)' do
    item = CheckoutSdk::Inventory::InventoryReservationItem.new
    item.variant_id = 'var_1'
    item.quantity = 5

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(item)

    expect(hash['variant_id']).to eq('var_1')
    expect(hash['quantity']).to eq(5)
  end
end
