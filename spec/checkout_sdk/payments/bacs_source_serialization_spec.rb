# frozen_string_literal: true

RSpec.describe 'Bacs and SEPA payment source serialization' do
  describe CheckoutSdk::Payments::BacsSource do
    it 'serializes type and id, the only two fields the schema declares' do
      source = described_class.new
      source.id = 'src_wmlfc3zyhqzehihu7giusaaawu'

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(source)

      expect(hash['type']).to eq('bacs')
      expect(hash['id']).to eq('src_wmlfc3zyhqzehihu7giusaaawu')
      expect(hash.keys.sort).to eq(%w[id type])
    end

    it 'sets the source type from the shared enum' do
      expect(described_class.new.type).to eq(CheckoutSdk::Common::PaymentSourceType::BACS)
    end
  end

  describe CheckoutSdk::Payments::SepaSource do
    it 'serializes mandate_type alongside the other declared fields' do
      holder = CheckoutSdk::Common::AccountHolder.new
      holder.first_name = 'John'
      holder.last_name = 'Wick'
      # Lowercase: see the note on SepaSource#account_holder.
      holder.type = CheckoutSdk::Common::AccountHolderType::INDIVIDUAL

      source = described_class.new
      source.country = CheckoutSdk::Common::Country::FR
      source.account_number = 'FR7630006000011234567890189'
      source.currency = CheckoutSdk::Common::Currency::EUR
      source.mandate_id = '123456'
      source.mandate_type = CheckoutSdk::Instruments::SepaMandateType::B2B
      source.date_of_signature = '2026-08-02'
      source.account_holder = holder

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(source)

      expect(hash['type']).to eq('sepa')
      expect(hash['country']).to eq('FR')
      expect(hash['account_number']).to eq('FR7630006000011234567890189')
      expect(hash['currency']).to eq('EUR')
      expect(hash['mandate_id']).to eq('123456')
      expect(hash['mandate_type']).to eq('B2B')
      expect(hash['date_of_signature']).to eq('2026-08-02')
      expect(hash['account_holder']['type']).to eq('individual')
    end

    it 'omits bank_code when it is not set' do
      source = described_class.new
      source.account_number = 'FR7630006000011234567890189'

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(source)

      # bank_code is declared by no SEPA schema and is retained only for
      # retro-compatibility. It must not appear unless the caller sets it.
      expect(hash).not_to have_key('bank_code')
    end
  end
end
