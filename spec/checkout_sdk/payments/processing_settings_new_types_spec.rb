# frozen_string_literal: true

# Coverage for the classes and enums added with the nine ProcessingSettings properties.
# They shipped with no specs at all, which matters most for ProcessingCardType: its lowercase
# values are a deliberate decision against the family's usual Credit/Debit casing, and nothing
# would have caught a "tidy-up" that changed them.

RSpec.describe CheckoutSdk::Payments::Aggregator do
  it 'exposes the three specification properties' do
    aggregator = described_class.new
    aggregator.sub_merchant_id = '9cf70789ba90123'
    aggregator.aggregator_id_visa = '10012345'
    aggregator.aggregator_id_mc = '00000123456'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(aggregator)

    expect(hash).to eq('sub_merchant_id' => '9cf70789ba90123',
                       'aggregator_id_visa' => '10012345',
                       'aggregator_id_mc' => '00000123456')
  end

  it 'omits unset properties' do
    expect(CheckoutSdk::JsonSerializer.to_custom_hash(described_class.new)).to eq({})
  end
end

RSpec.describe CheckoutSdk::Payments::PartnerCustomerRiskData do
  it 'serializes as a single key-and-value object' do
    risk = described_class.new
    risk.key = 'customer_tier'
    risk.value = 'gold'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(risk)

    expect(hash).to eq('key' => 'customer_tier', 'value' => 'gold')
  end
end

RSpec.describe CheckoutSdk::Payments::PanProcessedType do
  it 'carries the specification values' do
    expect(described_class::FPAN).to eq('fpan')
    expect(described_class::DPAN).to eq('dpan')
  end
end

RSpec.describe CheckoutSdk::Payments::AchServiceType do
  it 'carries the specification values' do
    expect(described_class::SAME_DAY).to eq('same_day')
    expect(described_class::STANDARD).to eq('standard')
  end
end

RSpec.describe CheckoutSdk::Payments::ProcessingCardType do
  # Deliberately lowercase. The specification's enum here is credit/debit, while every generic
  # card-type enum across the SDK family uses Credit/Debit or CREDIT/DEBIT. .NET types this
  # property as its generic CardType and so sends the wrong casing; Go added a dedicated
  # ProcessingCardType to avoid that, and Ruby follows Go. Do not "normalise" these values.
  it 'carries the specification values in lowercase' do
    expect(described_class::CREDIT).to eq('credit')
    expect(described_class::DEBIT).to eq('debit')
  end
end

RSpec.describe 'ProcessingSettings properties added 2026-09-28' do
  it 'serializes all nine, with aggregator and partner_customer_risk_data nested' do
    settings = CheckoutSdk::Payments::ProcessingSettings.new
    settings.surcharge_amount = 200
    settings.foreign_retailer_amount = 200
    settings.reconciliation_id = '4123495123'
    settings.pan_preference = CheckoutSdk::Payments::PanProcessedType::FPAN
    settings.provision_network_token = true
    settings.card_type = CheckoutSdk::Payments::ProcessingCardType::CREDIT
    settings.service_type = CheckoutSdk::Payments::AchServiceType::STANDARD

    aggregator = CheckoutSdk::Payments::Aggregator.new
    aggregator.sub_merchant_id = '9cf70789ba90123'
    settings.aggregator = aggregator

    risk = CheckoutSdk::Payments::PartnerCustomerRiskData.new
    risk.key = 'customer_tier'
    risk.value = 'gold'
    settings.partner_customer_risk_data = risk

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(settings)

    expect(hash).to eq(
      'surcharge_amount' => 200,
      'foreign_retailer_amount' => 200,
      'reconciliation_id' => '4123495123',
      'pan_preference' => 'fpan',
      'provision_network_token' => true,
      'card_type' => 'credit',
      'service_type' => 'standard',
      'aggregator' => { 'sub_merchant_id' => '9cf70789ba90123' },
      'partner_customer_risk_data' => { 'key' => 'customer_tier', 'value' => 'gold' }
    )
  end

  it 'keeps the number-typed amounts fractional' do
    # The swagger types these six as `number`, and the live API accepts and echoes back 10.5.
    # Ruby documents them as Numeric; Java, Go and .NET had to be retyped off integers.
    settings = CheckoutSdk::Payments::ProcessingSettings.new
    settings.tax_amount = 10.5
    settings.discount_amount = 0.25

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(settings)

    expect(hash['tax_amount']).to eq(10.5)
    expect(hash['discount_amount']).to eq(0.25)
  end
end
