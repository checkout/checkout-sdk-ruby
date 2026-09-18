# frozen_string_literal: true

RSpec.describe 'InventoryMoney serialization' do
  it 'serializes all properties (roundtrip)' do
    money = CheckoutSdk::Inventory::InventoryMoney.new
    money.amount = 1999
    money.currency = 'USD'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(money)

    expect(hash['amount']).to eq(1999)
    expect(hash['currency']).to eq('USD')
  end
end

RSpec.describe 'InventorySetProductRequest serialization' do
  it 'serializes all properties, including nested price/sale_price (roundtrip)' do
    price = CheckoutSdk::Inventory::InventoryMoney.new
    price.amount = 2999
    price.currency = 'USD'

    sale_price = CheckoutSdk::Inventory::InventoryMoney.new
    sale_price.amount = 1999
    sale_price.currency = 'USD'

    request = CheckoutSdk::Inventory::InventorySetProductRequest.new
    request.title = 'Running shoes'
    request.description = 'Lightweight running shoes'
    request.product_url = 'https://example.com/products/running-shoes'
    request.image_url = 'https://example.com/images/running-shoes.png'
    request.additional_image_urls = ['https://example.com/images/running-shoes-2.png']
    request.video_url = 'https://example.com/videos/running-shoes.mp4'
    request.model_3d_url = 'https://example.com/models/running-shoes.glb'
    request.sku = 'SKU-1'
    request.gtin = '00012345678905'
    request.mpn = 'MPN-1'
    request.brand = 'Acme'
    request.category = 'Footwear'
    request.price = price
    request.sale_price = sale_price
    request.sale_price_starts_at = Time.parse('2026-01-01T00:00:00Z')
    request.sale_price_ends_at = Time.parse('2026-01-31T23:59:59Z')
    request.group_id = 'grp_1'
    request.group_title = 'Running shoes group'
    request.color = 'red'
    request.size = 'M'
    request.size_system = 'US'
    request.gender = 'unisex'
    request.condition = 'new'
    request.material = 'mesh'
    request.age_group = 'adult'
    request.length = 30.5
    request.width = 12.0
    request.height = 10.0
    request.dimension_unit = 'cm'
    request.weight = 0.8
    request.weight_unit = 'kg'
    request.expiration_date = Time.parse('2027-01-01T00:00:00Z')
    request.harmonized_system_code = '6404.11'
    request.country_of_origin = 'US'
    request.seller_name = 'Acme Store'
    request.seller_url = 'https://example.com'
    request.seller_privacy_policy = 'https://example.com/privacy'
    request.seller_tos = 'https://example.com/tos'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

    expect(hash['title']).to eq('Running shoes')
    expect(hash['description']).to eq('Lightweight running shoes')
    expect(hash['product_url']).to eq('https://example.com/products/running-shoes')
    expect(hash['image_url']).to eq('https://example.com/images/running-shoes.png')
    expect(hash['additional_image_urls']).to eq(['https://example.com/images/running-shoes-2.png'])
    expect(hash['video_url']).to eq('https://example.com/videos/running-shoes.mp4')
    expect(hash['model_3d_url']).to eq('https://example.com/models/running-shoes.glb')
    expect(hash['sku']).to eq('SKU-1')
    expect(hash['gtin']).to eq('00012345678905')
    expect(hash['mpn']).to eq('MPN-1')
    expect(hash['brand']).to eq('Acme')
    expect(hash['category']).to eq('Footwear')
    expect(hash['price']).to eq({ 'amount' => 2999, 'currency' => 'USD' })
    expect(hash['sale_price']).to eq({ 'amount' => 1999, 'currency' => 'USD' })
    expect(hash['sale_price_starts_at']).to eq(Time.parse('2026-01-01T00:00:00Z'))
    expect(hash['sale_price_ends_at']).to eq(Time.parse('2026-01-31T23:59:59Z'))
    expect(hash['group_id']).to eq('grp_1')
    expect(hash['group_title']).to eq('Running shoes group')
    expect(hash['color']).to eq('red')
    expect(hash['size']).to eq('M')
    expect(hash['size_system']).to eq('US')
    expect(hash['gender']).to eq('unisex')
    expect(hash['condition']).to eq('new')
    expect(hash['material']).to eq('mesh')
    expect(hash['age_group']).to eq('adult')
    expect(hash['length']).to eq(30.5)
    expect(hash['width']).to eq(12.0)
    expect(hash['height']).to eq(10.0)
    expect(hash['dimension_unit']).to eq('cm')
    expect(hash['weight']).to eq(0.8)
    expect(hash['weight_unit']).to eq('kg')
    expect(hash['expiration_date']).to eq(Time.parse('2027-01-01T00:00:00Z'))
    expect(hash['harmonized_system_code']).to eq('6404.11')
    expect(hash['country_of_origin']).to eq('US')
    expect(hash['seller_name']).to eq('Acme Store')
    expect(hash['seller_url']).to eq('https://example.com')
    expect(hash['seller_privacy_policy']).to eq('https://example.com/privacy')
    expect(hash['seller_tos']).to eq('https://example.com/tos')
  end

  it 'deserializes the swagger example' do
    json = '{"title":"Running shoes","description":"Lightweight running shoes",' \
           '"product_url":"https://example.com/products/running-shoes",' \
           '"image_url":"https://example.com/images/running-shoes.png",' \
           '"condition":"new","price":{"amount":2999,"currency":"USD"}}'
    parsed = JSON.parse(json, object_class: OpenStruct)

    expect(parsed.title).to eq('Running shoes')
    expect(parsed.description).to eq('Lightweight running shoes')
    expect(parsed.product_url).to eq('https://example.com/products/running-shoes')
    expect(parsed.image_url).to eq('https://example.com/images/running-shoes.png')
    expect(parsed.condition).to eq('new')
    expect(parsed.price.amount).to eq(2999)
    expect(parsed.price.currency).to eq('USD')
  end
end
