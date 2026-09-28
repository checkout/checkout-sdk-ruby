# frozen_string_literal: true

# Response-side `processing` object (swagger ProcessingData, GET /payments/{id}).
# Verifies every attribute of the schema is exposed and round-trips through the accessors.
PROCESSING_DATA_ATTRIBUTES = {
  preferred_scheme: 'cartes_bancaires',
  app_id: 'com.iap.linker_portal',
  partner_customer_id: '2102209000001106125F8',
  partner_payment_id: '440644309099499894406',
  tax_amount: 1000,
  locale: 'en-US',
  retrieval_reference_number: '909913440644',
  partner_order_id: 'ord_abc',
  partner_status: 'pending',
  partner_transaction_id: 'txn_abc',
  partner_error_codes: %w[ERR_001 ERR_002],
  partner_error_message: 'Payment declined',
  partner_authorization_code: 'auth_123',
  partner_authorization_response_code: '00',
  partner_fraud_status: 'Pending',
  partner_merchant_advice_code: '24',
  custom_payment_method_ids: %w[cpm_001],
  aft: true,
  merchant_category_code: '5311',
  scheme_merchant_id: '123456',
  pan_type_processed: 'fpan',
  fallback_source_used: false,
  failure_code: 'partner_error',
  partner_code: '999111',
  partner_response_code: 'ER_WRONG_TICKET',
  scheme: 'ACCEL',
  scheme_transaction_link_id: 'MTL-XYZ-789'
}.freeze

RSpec.describe CheckoutSdk::Payments::ProcessingData do
  PROCESSING_DATA_ATTRIBUTES.each do |attribute, value|
    it "exposes #{attribute}" do
      data = described_class.new
      data.public_send("#{attribute}=", value)

      expect(data.public_send(attribute)).to eq(value)
    end
  end

  it 'exposes accommodation_data and airline_data as collections' do
    data = described_class.new
    data.accommodation_data = [{ name: 'Grand Hotel' }]
    data.airline_data = [{ ticket: { number: '045-21351455613' } }]

    expect(data.accommodation_data.first[:name]).to eq('Grand Hotel')
    expect(data.airline_data.first[:ticket][:number]).to eq('045-21351455613')
  end

  # The assertion above only ever touched `ticket`, which is how the passenger cardinality defect
  # survived: nothing in the suite read `passenger` or a flight leg. These two cover the rest of
  # the sub-tree, both cardinalities of `passenger`, and the two renamed flight-leg keys.
  it 'exposes the full airline_data sub-tree with passenger as an array' do
    data = described_class.new
    data.airline_data = [{ ticket: { number: '045-21351455613', travel_package_indicator: 'B' },
                           passenger: [{ first_name: 'John', last_name: 'White',
                                         address: { country: 'US' } }],
                           flight_leg_details: [{ flight_number: '101', class_of_travelling: 'J',
                                                  stop_over_code: 'x' }] }]

    airline = data.airline_data.first
    expect(airline[:ticket][:travel_package_indicator]).to eq('B')
    expect(airline[:passenger].size).to eq(1)
    expect(airline[:passenger].first[:address][:country]).to eq('US')
    expect(airline[:flight_leg_details].first[:flight_number]).to eq('101')
    expect(airline[:flight_leg_details].first[:class_of_travelling]).to eq('J')
    expect(airline[:flight_leg_details].first[:stop_over_code]).to eq('x')
  end

  it 'exposes airline_data with passenger as a single object' do
    data = described_class.new
    data.airline_data = [{ passenger: { first_name: 'John', last_name: 'White' } }]

    expect(data.airline_data.first[:passenger][:first_name]).to eq('John')
  end

  it 'leaves every attribute nil when nothing is set' do
    data = described_class.new

    expect(PROCESSING_DATA_ATTRIBUTES.keys.map { |a| data.public_send(a) }).to all(be_nil)
  end
end
