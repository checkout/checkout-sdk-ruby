# frozen_string_literal: true

require 'json'

RSpec.describe CheckoutSdk::Payments::PayoutRequest do
  def wire(object)
    JSON.parse(JSON.generate(CheckoutSdk::JsonSerializer.to_custom_hash(object)))
  end

  let(:item) do
    item = CheckoutSdk::Payments::CardPayoutItem.new
    item.type = CheckoutSdk::Payments::ProductItemType::DIGITAL
    item.sub_type = CheckoutSdk::Payments::ProductSubType::STABLECOIN
    item
  end

  let(:processing) do
    processing = CheckoutSdk::Payments::CardPayoutProcessing.new
    processing.affiliate_id = 'AFF123'
    processing.affiliate_url = 'https://affiliate.example.com'
    processing.processing_speed = 'fast'
    processing.purchase_country = CheckoutSdk::Common::Country::GB
    processing
  end

  let(:segment) do
    segment = CheckoutSdk::Payments::PaymentSegment.new
    segment.brand = 'Acme'
    segment.business_category = 'Retail'
    segment.market = 'GB'
    segment
  end

  it 'serializes the card payout items, segment, previous_payment_id and processing keys' do
    request = described_class.new
    request.items = [item]
    request.segment = segment
    request.previous_payment_id = 'pay_fun26akvvjjerahhctaq2uzhu4'
    request.processing = processing

    expect(wire(request)).to eq(
      'items' => [{ 'type' => 'digital', 'sub_type' => 'stablecoin' }],
      'segment' => { 'brand' => 'Acme', 'business_category' => 'Retail', 'market' => 'GB' },
      'previous_payment_id' => 'pay_fun26akvvjjerahhctaq2uzhu4',
      'processing' => {
        'affiliate_id' => 'AFF123',
        'affiliate_url' => 'https://affiliate.example.com',
        'processing_speed' => 'fast',
        'purchase_country' => 'GB'
      }
    )
  end

  it 'round trips every new property through JSON' do
    request = described_class.new
    request.items = [item]
    request.processing = processing

    json = wire(request)

    expect(json['items'].first).to eq('type' => item.type, 'sub_type' => item.sub_type)
    %i[affiliate_id affiliate_url processing_speed purchase_country].each do |attr|
      expect(json['processing'][attr.to_s]).to eq(processing.public_send(attr))
    end
  end

  it 'omits the new properties when they are not set' do
    expect(wire(described_class.new)).to eq({})
  end
end
