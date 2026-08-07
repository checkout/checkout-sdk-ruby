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

  it 'leaves every attribute nil when nothing is set' do
    data = described_class.new

    expect(PROCESSING_DATA_ATTRIBUTES.keys.map { |a| data.public_send(a) }).to all(be_nil)
  end
end
