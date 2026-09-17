# frozen_string_literal: true

RSpec.describe CheckoutSdk::Payments::PaymentSetupIndustry do
  it 'serializes the accommodation and airline collections' do
    industry = described_class.new

    accommodation = CheckoutSdk::Payments::PaymentSetupAccommodation.new
    accommodation.name = 'Grand Hotel'
    industry.accommodation = [accommodation]

    airline = CheckoutSdk::Payments::PaymentSetupAirline.new
    airline.travel_type = 'domestic'
    industry.airline = [airline]

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(industry)

    expect(hash['accommodation']).to eq([{ 'name' => 'Grand Hotel' }])
    expect(hash['airline']).to eq([{ 'travel_type' => 'domestic' }])
  end
end
