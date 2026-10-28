# frozen_string_literal: true

def retry_to_json_hash(obj)
  JSON.parse(CheckoutSdk::JsonSerializer.to_custom_hash(obj).to_json)
end

def build_full_retry_request
  dunning = CheckoutSdk::Payments::DunningRetryRequest.new
  dunning.enabled = true
  dunning.max_attempts = 6
  dunning.end_after_days = 30
  downtime = CheckoutSdk::Payments::DowntimeRetryRequest.new
  downtime.enabled = false
  request = CheckoutSdk::Payments::PaymentRetryRequest.new
  request.enabled = true
  request.dunning = dunning
  request.downtime = downtime
  request
end

RSpec.describe CheckoutSdk::Payments::PaymentRetryRequest do
  it 'serializes all properties to the expected JSON' do
    expected = JSON.parse('{"enabled":true,"dunning":{"enabled":true,"max_attempts":6,"end_after_days":30},' \
                          '"downtime":{"enabled":false}}')
    expect(retry_to_json_hash(build_full_retry_request)).to eq(expected)
  end

  it 'serializes enabled false' do
    request = described_class.new
    request.enabled = false
    expect(retry_to_json_hash(request)).to eq(JSON.parse('{"enabled":false}'))
  end
end

RSpec.describe CheckoutSdk::Payments::DunningRetryRequest do
  it 'serializes all properties with enabled false' do
    request = described_class.new
    request.enabled = false
    request.max_attempts = 15
    request.end_after_days = 60
    expect(retry_to_json_hash(request)).to eq(JSON.parse('{"enabled":false,"max_attempts":15,"end_after_days":60}'))
  end
end

RSpec.describe CheckoutSdk::Payments::DowntimeRetryRequest do
  it 'serializes enabled false' do
    request = described_class.new
    request.enabled = false
    expect(retry_to_json_hash(request)).to eq(JSON.parse('{"enabled":false}'))
  end
end

RSpec.describe CheckoutSdk::Common::CustomerRetry do
  it 'serializes the swagger example' do
    expect(retry_to_json_hash(described_class.new.tap { |c| c.max_attempts = 2 }))
      .to eq(JSON.parse('{"max_attempts":2}'))
  end

  it 'serializes max_attempts 0' do
    expect(retry_to_json_hash(described_class.new.tap { |c| c.max_attempts = 0 }))
      .to eq(JSON.parse('{"max_attempts":0}'))
  end

  it 'keeps the deprecated Accounts alias pointing to the same class' do
    expect(CheckoutSdk::Accounts::CustomerRetry).to equal(described_class)
  end

  it 'is used by hosted payments, payment links and payment sessions' do
    [CheckoutSdk::Payments::HostedPaymentsSession, CheckoutSdk::Payments::PaymentLink,
     CheckoutSdk::Payments::PaymentSessionsRequest].each do |klass|
      request = klass.new
      request.customer_retry = described_class.new.tap { |c| c.max_attempts = 2 }
      expect(retry_to_json_hash(request)['customer_retry']).to eq(JSON.parse('{"max_attempts":2}'))
    end
  end
end

RSpec.describe 'instruction and payment_method_configuration on payment links and payment sessions' do
  it 'serializes instruction on payment links and payment sessions' do
    [CheckoutSdk::Payments::PaymentLink, CheckoutSdk::Payments::PaymentSessionsRequest].each do |klass|
      request = klass.new
      request.instruction = CheckoutSdk::Payments::HostedPaymentInstruction.new.tap { |i| i.purpose = 'donations' }
      expect(retry_to_json_hash(request)['instruction']).to eq(JSON.parse('{"purpose":"donations"}'))
    end
  end

  it 'serializes payment_method_configuration on payment links' do
    request = CheckoutSdk::Payments::PaymentLink.new
    request.payment_method_configuration = CheckoutSdk::Payments::PaymentMethodConfiguration.new
    expect(retry_to_json_hash(request)).to have_key('payment_method_configuration')
  end
end
