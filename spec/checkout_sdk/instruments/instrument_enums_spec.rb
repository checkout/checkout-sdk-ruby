# frozen_string_literal: true

RSpec.describe 'Instrument and payment-source enums' do
  describe CheckoutSdk::Common::InstrumentType do
    it 'declares every value the specification maps on the create discriminator' do
      expect(described_class::BANK_ACCOUNT).to eq('bank_account')
      expect(described_class::CARD).to eq('card')
      expect(described_class::TOKEN).to eq('token')
      expect(described_class::SEPA).to eq('sepa')
      expect(described_class::ACH).to eq('ach')
      expect(described_class::BACS).to eq('bacs')
      # Previous API (ABC) only, not on any current-API instrument schema.
      expect(described_class::CARD_TOKEN).to eq('card_token')
    end

    it 'is all lowercase on the wire' do
      values = described_class.constants.map { |c| described_class.const_get(c) }
      expect(values).to all(satisfy { |v| v == v.downcase })
    end
  end

  describe CheckoutSdk::Instruments::PaymentNetwork do
    it 'declares all six values lowercase' do
      # Regression guard. Four of these were previously capitalized (Fps, Ach,
      # Fedwire, Swift) and were sent as query-parameter values, which the API does
      # not match. The specification declares all six lowercase.
      expect(described_class::LOCAL).to eq('local')
      expect(described_class::SEPA).to eq('sepa')
      expect(described_class::FPS).to eq('fps')
      expect(described_class::ACH).to eq('ach')
      expect(described_class::FEDWIRE).to eq('fedwire')
      expect(described_class::SWIFT).to eq('swift')

      values = described_class.constants.map { |c| described_class.const_get(c) }
      expect(values).to all(satisfy { |v| v == v.downcase })
      expect(values.sort).to eq(%w[ach fedwire fps local sepa swift])
    end
  end

  describe CheckoutSdk::Instruments::InstrumentAccountHolderType do
    it 'declares individual and corporate only' do
      values = described_class.constants.map { |c| described_class.const_get(c) }
      expect(values.sort).to eq(%w[corporate individual])
    end
  end

  describe CheckoutSdk::Common::AccountHolderType do
    it 'declares government, which the AccountHolder schema requires' do
      expect(described_class::GOVERNMENT).to eq('government')
    end
  end

  describe CheckoutSdk::Instruments::SepaMandateType do
    it 'declares Core and B2B capitalized' do
      expect(described_class::CORE).to eq('Core')
      expect(described_class::B2B).to eq('B2B')
    end
  end

  describe CheckoutSdk::Common::PaymentSourceType do
    it 'declares bacs alongside sepa and ach' do
      expect(described_class::BACS).to eq('bacs')
      expect(described_class::SEPA).to eq('sepa')
      expect(described_class::ACH).to eq('ach')
    end
  end

  describe CheckoutSdk::Instruments::BankAccountFieldQuery do
    it 'serializes both filters to their hyphenated query-parameter names' do
      query = described_class.new
      query.account_holder_type = CheckoutSdk::Common::AccountHolderType::CORPORATE
      query.payment_network = CheckoutSdk::Instruments::PaymentNetwork::FPS

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(query)

      expect(hash['account-holder-type']).to eq('corporate')
      expect(hash['payment-network']).to eq('fps')
    end
  end
end
