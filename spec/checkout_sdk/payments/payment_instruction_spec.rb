# frozen_string_literal: true

RSpec.describe CheckoutSdk::Payments::PaymentInstruction do
  it 'serializes the bank payout scheme and remittance reference' do
    remittance = CheckoutSdk::Payments::InstructionRemittance.new
    remittance.reference = 'INV-2026-0001'
    instruction = described_class.new
    instruction.scheme = CheckoutSdk::Payments::InstructionScheme::LOCAL
    instruction.remittance = remittance
    request = CheckoutSdk::Payments::PayoutRequest.new
    request.instruction = instruction

    hash = JSON.parse(JSON.generate(CheckoutSdk::JsonSerializer.to_custom_hash(request)))

    expect(hash['instruction']).to eq('scheme' => 'local', 'remittance' => { 'reference' => 'INV-2026-0001' })
  end
end
