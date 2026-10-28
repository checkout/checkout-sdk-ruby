# frozen_string_literal: true

RSpec.describe CheckoutSdk::Payments::PaymentType do
  it 'declares exactly the spec payment_type values' do
    values = described_class.constants.map { |c| described_class.const_get(c) }

    expect(values).to contain_exactly('Regular', 'Recurring', 'MOTO', 'Installment', 'PayLater', 'Unscheduled')
  end

  it 'sends MOTO in upper case and PayLater on the wire' do
    request = CheckoutSdk::Payments::PaymentRequest.new
    request.payment_type = described_class::MOTO
    expect(CheckoutSdk::JsonSerializer.to_custom_hash(request)['payment_type']).to eq('MOTO')

    request.payment_type = described_class::PAY_LATER
    expect(CheckoutSdk::JsonSerializer.to_custom_hash(request)['payment_type']).to eq('PayLater')
  end
end
