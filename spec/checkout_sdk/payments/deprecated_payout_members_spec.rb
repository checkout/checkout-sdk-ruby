# frozen_string_literal: true

require 'json'

# Deprecated payout members are retained for backwards compatibility until the next major version, so
# they must keep serializing under their wire keys.
RSpec.describe CheckoutSdk::Payments::PayoutRequest do
  def wire(object)
    JSON.parse(JSON.generate(CheckoutSdk::JsonSerializer.to_custom_hash(object)))
  end

  it 'still serializes the deprecated instruction members' do
    instruction = CheckoutSdk::Payments::PaymentInstruction.new
    instruction.charge_bearer = CheckoutSdk::Payments::ChargeBearer::OUR
    instruction.repair = true
    instruction.quote_id = 'qte_mbabizu24mvu3mela5njyhpit4'
    instruction.scheme = CheckoutSdk::Payments::InstructionScheme::SWIFT
    instruction.skip_expiry = true
    instruction.mvv = '0123456789'
    request = described_class.new
    request.instruction = instruction

    expect(wire(request)['instruction']).to eq('charge_bearer' => 'OUR',
                                               'repair' => true,
                                               'quote_id' => 'qte_mbabizu24mvu3mela5njyhpit4',
                                               'scheme' => 'swift',
                                               'skip_expiry' => true,
                                               'mvv' => '0123456789')
  end

  it 'still serializes the deprecated source amount' do
    source = CheckoutSdk::Payments::CurrencyAccountSource.new
    source.id = 'ca_y3oqhf46pyzuxjbcn2giaqnb44'
    source.amount = 1000
    request = described_class.new
    request.source = source

    expect(wire(request)['source']).to eq('type' => 'currency_account',
                                          'id' => 'ca_y3oqhf46pyzuxjbcn2giaqnb44',
                                          'amount' => 1000)
  end

  it 'still serializes the deprecated bank account destination bank' do
    bank = CheckoutSdk::Common::BankDetails.new
    bank.name = 'Lloyds TSB'
    bank.branch = 'Bournemouth'
    destination = CheckoutSdk::Payments::BankAccountDestination.new
    destination.bank = bank
    request = described_class.new
    request.destination = destination

    expect(wire(request)['destination']).to eq('type' => 'bank_account',
                                               'bank' => { 'name' => 'Lloyds TSB', 'branch' => 'Bournemouth' })
  end

  it 'still serializes the deprecated account holder full_name and gender' do
    account_holder = CheckoutSdk::Common::AccountHolder.new
    account_holder.full_name = 'John Smith'
    account_holder.gender = 'male'

    expect(wire(account_holder)).to eq('full_name' => 'John Smith', 'gender' => 'male')
  end

  it 'exposes the residential status values of the spec' do
    expect(CheckoutSdk::Common::ResidentialStatusType::RESIDENT).to eq('resident')
    expect(CheckoutSdk::Common::ResidentialStatusType::NON_RESIDENT).to eq('non_resident')
  end
end
