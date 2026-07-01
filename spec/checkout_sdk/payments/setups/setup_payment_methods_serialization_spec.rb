# frozen_string_literal: true

RSpec.describe 'Payment Setups payment-method configs serialization' do
  describe CheckoutSdk::Payments::BacsPaymentMethod do
    it 'serializes its fields to their swagger keys' do
      pm = described_class.new
      pm.status = 'available'
      pm.flags = %w[flag_a]
      pm.instrument_id = 'src_wkq7552u245upl5h75x24554xy'
      pm.initialization = 'setup'
      pm.account_holder = { 'type' => 'individual', 'first_name' => 'John' }
      pm.account_number = '12345678'
      pm.bank_code = '200000'
      pm.country = 'GB'
      pm.currency = 'GBP'
      pm.allow_partial_match = true

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(pm)

      expect(hash['status']).to eq('available')
      expect(hash['flags']).to eq(%w[flag_a])
      expect(hash['instrument_id']).to eq('src_wkq7552u245upl5h75x24554xy')
      expect(hash['initialization']).to eq('setup')
      expect(hash['account_holder']).to eq({ 'type' => 'individual', 'first_name' => 'John' })
      expect(hash['account_number']).to eq('12345678')
      expect(hash['bank_code']).to eq('200000')
      expect(hash['country']).to eq('GB')
      expect(hash['currency']).to eq('GBP')
      expect(hash['allow_partial_match']).to be(true)
    end
  end

  describe CheckoutSdk::Payments::CardPresentPaymentMethod do
    it 'serializes its fields to their swagger keys' do
      pm = described_class.new
      pm.status = 'available'
      pm.flags = %w[flag_a]
      pm.track2 = 'track2-data'
      pm.emv = 'emv-data'
      pm.entry_mode = 'contactless'
      pm.pin = { 'key_set_id' => 'ks_1', 'block' => 'b', 'block_format' => 'iso0' }
      pm.store_for_future_use = true
      pm.name = 'John Smith'

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(pm)

      expect(hash['status']).to eq('available')
      expect(hash['flags']).to eq(%w[flag_a])
      expect(hash['track2']).to eq('track2-data')
      expect(hash['emv']).to eq('emv-data')
      expect(hash['entry_mode']).to eq('contactless')
      expect(hash['pin']).to eq({ 'key_set_id' => 'ks_1', 'block' => 'b', 'block_format' => 'iso0' })
      expect(hash['store_for_future_use']).to be(true)
      expect(hash['name']).to eq('John Smith')
    end
  end

  describe CheckoutSdk::Payments::PayByBankPaymentMethod do
    it 'serializes bank_id, status, flags and action' do
      pm = described_class.new
      pm.bank_id = 'ob-natwest'
      pm.status = 'available'
      pm.flags = %w[flag_a]
      pm.action = { 'type' => 'select_bank', 'banks' => [{ 'bank_id' => 'ob-natwest' }] }

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(pm)

      expect(hash['bank_id']).to eq('ob-natwest')
      expect(hash['status']).to eq('available')
      expect(hash['flags']).to eq(%w[flag_a])
      expect(hash['action']).to eq({ 'type' => 'select_bank', 'banks' => [{ 'bank_id' => 'ob-natwest' }] })
    end
  end

  describe CheckoutSdk::Payments::StablecoinPaymentMethod do
    it 'serializes its response fields' do
      pm = described_class.new
      pm.status = 'available'
      pm.flags = %w[flag_a]

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(pm)

      expect(hash['status']).to eq('available')
      expect(hash['flags']).to eq(%w[flag_a])
    end
  end

  describe 'order amount_allocations (reuses Common::AmountAllocations)' do
    it 'serializes id, amount, reference and commission' do
      allocation = CheckoutSdk::Common::AmountAllocations.new
      allocation.id = 'ent_w4jelhppmfiufdnatam37wrfc4'
      allocation.amount = 1000
      allocation.reference = 'ORD-5023-4E89'
      allocation.commission = CheckoutSdk::Common::Commission.new

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(allocation)

      expect(hash['id']).to eq('ent_w4jelhppmfiufdnatam37wrfc4')
      expect(hash['amount']).to eq(1000)
      expect(hash['reference']).to eq('ORD-5023-4E89')
      expect(hash).to have_key('commission')
    end
  end
end
