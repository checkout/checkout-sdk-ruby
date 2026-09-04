# frozen_string_literal: true

RSpec.describe 'SEPA and ACH instrument serialization' do
  describe CheckoutSdk::Instruments::InstrumentSepa do
    it 'serializes every declared field of StoreSepaInstrumentRequest' do
      address = CheckoutSdk::Instruments::CreateSepaBillingAddress.new
      address.address_line1 = 'Cloverfield St.'
      address.address_line2 = '23A'
      address.city = 'London'
      address.zip = 'SW1A 1AA'
      address.country = CheckoutSdk::Common::Country::GB

      holder = CheckoutSdk::Instruments::CreateSepaAccountHolder.new
      holder.first_name = 'John'
      holder.last_name = 'Smith'
      holder.billing_address = address
      holder.company_name = 'Checkout.com'
      holder.type = CheckoutSdk::Instruments::InstrumentAccountHolderType::INDIVIDUAL

      data = CheckoutSdk::Instruments::CreateSepaInstrumentData.new
      data.account_number = 'FR2810096000509685512959O86'
      data.country = CheckoutSdk::Common::Country::FR
      data.currency = CheckoutSdk::Common::Currency::EUR
      data.payment_type = CheckoutSdk::Instruments::SepaPaymentType::RECURRING
      data.type = CheckoutSdk::Instruments::SepaMandateType::CORE
      data.mandate_id = '1234567890'
      data.date_of_signature = '2026-07-15'

      request = described_class.new
      request.instrument_data = data
      request.account_holder = holder

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

      expect(hash['type']).to eq('sepa')
      expect(hash['instrument_data']['account_number']).to eq('FR2810096000509685512959O86')
      expect(hash['instrument_data']['country']).to eq('FR')
      expect(hash['instrument_data']['currency']).to eq('EUR')
      expect(hash['instrument_data']['payment_type']).to eq('recurring')
      expect(hash['instrument_data']['type']).to eq('Core')
      expect(hash['instrument_data']['mandate_id']).to eq('1234567890')
      expect(hash['instrument_data']['date_of_signature']).to eq('2026-07-15')
      expect(hash['account_holder']['type']).to eq('individual')
      expect(hash['account_holder']['billing_address'].keys.sort)
        .to eq(%w[address_line1 address_line2 city country zip])
    end

    it 'sends date_of_signature as a yyyy-MM-dd string, matching format: date' do
      data = CheckoutSdk::Instruments::CreateSepaInstrumentData.new
      data.date_of_signature = '2026-07-15'

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(data)

      # The field is format: date. The class it replaced typed this as DateTime,
      # which serialized a full timestamp the API does not accept.
      expect(hash['date_of_signature']).to be_a(String)
      expect(hash['date_of_signature']).to match(/\A\d{4}-\d{2}-\d{2}\z/)
    end
  end

  describe CheckoutSdk::Instruments::UpdateInstrumentSepa do
    it 'sets type to sepa and serializes the mandate fields' do
      data = CheckoutSdk::Instruments::UpdateSepaInstrumentData.new
      data.account_number = 'FR2810096000509685512959O86'
      data.country = CheckoutSdk::Common::Country::FR
      data.currency = CheckoutSdk::Common::Currency::EUR
      data.payment_type = CheckoutSdk::Instruments::SepaPaymentType::REGULAR

      request = described_class.new
      request.instrument_data = data

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

      expect(hash['type']).to eq('sepa')
      expect(hash['instrument_data']['payment_type']).to eq('regular')
      expect(hash).not_to have_key('account_holder')
    end
  end

  describe CheckoutSdk::Instruments::InstrumentAch do
    it 'serializes every declared field of StoreAchInstrumentRequest' do
      holder = CheckoutSdk::Instruments::CreateAchAccountHolder.new
      holder.first_name = 'John'
      holder.last_name = 'Smith'
      holder.company_name = 'Checkout.com'
      holder.type = CheckoutSdk::Instruments::InstrumentAccountHolderType::CORPORATE

      data = CheckoutSdk::Instruments::CreateAchInstrumentData.new
      data.account_type = CheckoutSdk::Instruments::AchAccountType::CHECKING
      data.account_number = '136549956'
      data.bank_code = '021000021'
      data.currency = CheckoutSdk::Common::Currency::USD
      data.country = CheckoutSdk::Common::Country::US

      request = described_class.new
      request.instrument_data = data
      request.account_holder = holder

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

      expect(hash['type']).to eq('ach')
      expect(hash['instrument_data'].keys.sort)
        .to eq(%w[account_number account_type bank_code country currency])
      expect(hash['instrument_data']['account_type']).to eq('checking')
      expect(hash['instrument_data']['account_number']).to eq('136549956')
      expect(hash['instrument_data']['bank_code']).to eq('021000021')
      expect(hash['instrument_data']['currency']).to eq('USD')
      expect(hash['instrument_data']['country']).to eq('US')
      # The ACH account holder declares no billing_address at all.
      expect(hash['account_holder'].keys.sort)
        .to eq(%w[company_name first_name last_name type])
      expect(hash['account_holder']['type']).to eq('corporate')
    end
  end

  describe CheckoutSdk::Instruments::UpdateInstrumentAch do
    it 'sets type to ach' do
      data = CheckoutSdk::Instruments::UpdateAchInstrumentData.new
      data.account_type = CheckoutSdk::Instruments::AchAccountType::SAVINGS

      request = described_class.new
      request.instrument_data = data

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

      expect(hash['type']).to eq('ach')
      expect(hash['instrument_data']['account_type']).to eq('savings')
    end
  end

  describe CheckoutSdk::Instruments::AchAccountType do
    it 'declares savings and checking only' do
      expect(described_class::SAVINGS).to eq('savings')
      expect(described_class::CHECKING).to eq('checking')

      values = described_class.constants.map { |c| described_class.const_get(c) }
      expect(values.sort).to eq(%w[checking savings])
    end
  end
end
