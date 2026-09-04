# frozen_string_literal: true

RSpec.describe CheckoutSdk::Apm::BacsNotificationRequest do
  # Every value below is the example the specification gives for that field.
  def full_request
    request = described_class.new
    request.source_id = 'src_wmlfc3zyhqzehihu7giusaaawu'
    request.notification_type = CheckoutSdk::Apm::BacsNotificationType::ADVANCE_NOTICE
    request.collection_date = '2026-07-15'
    request.amount = 4999
    request.currency = 'GBP'
    request.reference = 'INV-12345'
    request.customer_email = 'customer@example.com'
    request.billing_descriptor = 'CHECKOUT'
    request.support_email = 'support@test.com'
    request.support_phone = '+447700900123'
    request
  end

  it 'serializes all ten fields to their exact snake_case keys' do
    hash = CheckoutSdk::JsonSerializer.to_custom_hash(full_request)

    expect(hash['source_id']).to eq('src_wmlfc3zyhqzehihu7giusaaawu')
    expect(hash['notification_type']).to eq('advance_notice')
    expect(hash['collection_date']).to eq('2026-07-15')
    expect(hash['amount']).to eq(4999)
    expect(hash['currency']).to eq('GBP')
    expect(hash['reference']).to eq('INV-12345')
    expect(hash['customer_email']).to eq('customer@example.com')
    expect(hash['billing_descriptor']).to eq('CHECKOUT')
    expect(hash['support_email']).to eq('support@test.com')
    expect(hash['support_phone']).to eq('+447700900123')
  end

  it 'serializes exactly the ten declared keys and nothing else' do
    hash = CheckoutSdk::JsonSerializer.to_custom_hash(full_request)

    expect(hash.keys.sort).to eq(%w[amount
                                    billing_descriptor
                                    collection_date
                                    currency
                                    customer_email
                                    notification_type
                                    reference
                                    source_id
                                    support_email
                                    support_phone])
  end

  it 'omits the two optional fields entirely when they are not set' do
    request = described_class.new
    request.source_id = 'src_wmlfc3zyhqzehihu7giusaaawu'
    request.notification_type = CheckoutSdk::Apm::BacsNotificationType::ADVANCE_NOTICE
    request.collection_date = '2026-07-15'
    request.amount = 4999
    request.currency = 'GBP'
    request.customer_email = 'customer@example.com'
    request.billing_descriptor = 'CHECKOUT'
    request.support_email = 'support@test.com'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

    # reference and support_phone are the only optional fields. They must be absent
    # from the JSON, not present as nil.
    expect(hash).not_to have_key('reference')
    expect(hash).not_to have_key('support_phone')
    expect(hash.keys.length).to eq(8)
  end

  it 'sends collection_date as a yyyy-MM-dd string, matching format: date' do
    hash = CheckoutSdk::JsonSerializer.to_custom_hash(full_request)

    expect(hash['collection_date']).to be_a(String)
    expect(hash['collection_date']).to match(/\A\d{4}-\d{2}-\d{2}\z/)
  end

  describe CheckoutSdk::Apm::BacsNotificationType do
    it 'declares advance_notice as its only value' do
      expect(described_class::ADVANCE_NOTICE).to eq('advance_notice')

      values = described_class.constants.map { |c| described_class.const_get(c) }
      expect(values).to eq(%w[advance_notice])
    end
  end
end
