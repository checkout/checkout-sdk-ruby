# frozen_string_literal: true

RSpec.describe 'Bacs instrument serialization' do
  describe CheckoutSdk::Instruments::InstrumentBacs do
    def full_store_request
      address = CheckoutSdk::Instruments::CreateBacsBillingAddress.new
      address.address_line1 = 'Cloverfield St.'
      address.address_line2 = '23A'
      address.city = 'London'
      address.zip = 'SW1A 1AA'
      address.country = CheckoutSdk::Common::Country::GB

      holder = CheckoutSdk::Instruments::CreateBacsAccountHolder.new
      holder.first_name = 'John'
      holder.last_name = 'Smith'
      holder.billing_address = address

      account = CheckoutSdk::Instruments::CreateBacsInstrumentAccount.new
      account.processing_channel_id = 'pc_q4dbxom5jbgudnjzjpz7j2z6uq'

      data = CheckoutSdk::Instruments::CreateBacsInstrumentData.new
      data.account_number = '86753246'
      data.bank_code = '040004'
      data.country = CheckoutSdk::Common::Country::GB
      data.currency = CheckoutSdk::Common::Currency::GBP
      data.payment_type = CheckoutSdk::Instruments::BacsPaymentType::RECURRING
      data.allow_partial_match = false

      request = described_class.new
      request.account = account
      request.instrument_data = data
      request.account_holder = holder
      request
    end

    it 'sets type to bacs' do
      expect(described_class.new.type).to eq('bacs')
    end

    it 'serializes every declared field of StoreBacsInstrumentRequest' do
      hash = CheckoutSdk::JsonSerializer.to_custom_hash(full_store_request)

      expect(hash['type']).to eq('bacs')
      expect(hash['account']['processing_channel_id']).to eq('pc_q4dbxom5jbgudnjzjpz7j2z6uq')
      expect(hash['instrument_data']['account_number']).to eq('86753246')
      expect(hash['instrument_data']['bank_code']).to eq('040004')
      expect(hash['instrument_data']['country']).to eq('GB')
      expect(hash['instrument_data']['currency']).to eq('GBP')
      expect(hash['instrument_data']['payment_type']).to eq('Recurring')
      expect(hash['instrument_data']['allow_partial_match']).to be(false)
      expect(hash['account_holder']['first_name']).to eq('John')
      expect(hash['account_holder']['last_name']).to eq('Smith')
      expect(hash['account_holder']['billing_address']['address_line1']).to eq('Cloverfield St.')
      expect(hash['account_holder']['billing_address']['address_line2']).to eq('23A')
      expect(hash['account_holder']['billing_address']['city']).to eq('London')
      expect(hash['account_holder']['billing_address']['zip']).to eq('SW1A 1AA')
      expect(hash['account_holder']['billing_address']['country']).to eq('GB')
    end

    it 'pins the exact key set at every level' do
      hash = CheckoutSdk::JsonSerializer.to_custom_hash(full_store_request)

      expect(hash.keys.sort).to eq(%w[account account_holder instrument_data type])
      expect(hash['instrument_data'].keys.sort).to eq(%w[account_number
                                                         allow_partial_match
                                                         bank_code
                                                         country
                                                         currency
                                                         payment_type])
      # The store account holder is a genuine subset: three properties only, with no
      # company_name or type. Those exist on the update shape.
      expect(hash['account_holder'].keys.sort).to eq(%w[billing_address first_name last_name])
    end

    it 'omits customer when it is not set' do
      hash = CheckoutSdk::JsonSerializer.to_custom_hash(full_store_request)

      expect(hash).not_to have_key('customer')
    end
  end

  describe CheckoutSdk::Instruments::UpdateInstrumentBacs do
    it 'sets type to bacs and serializes the update-only fields' do
      address = CheckoutSdk::Instruments::UpdateBacsBillingAddress.new
      address.address_line1 = 'Cloverfield St.'
      address.city = 'London'
      address.country = CheckoutSdk::Common::Country::GB

      holder = CheckoutSdk::Instruments::UpdateBacsAccountHolder.new
      holder.first_name = 'John'
      holder.last_name = 'Smith'
      holder.company_name = 'Checkout.com'
      holder.type = CheckoutSdk::Instruments::InstrumentAccountHolderType::CORPORATE
      holder.billing_address = address

      data = CheckoutSdk::Instruments::UpdateBacsInstrumentData.new
      data.payment_type = CheckoutSdk::Instruments::BacsPaymentType::REGULAR
      data.allow_partial_match = true

      request = described_class.new
      request.instrument_data = data
      request.account_holder = holder

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(request)

      expect(hash['type']).to eq('bacs')
      expect(hash['instrument_data']['payment_type']).to eq('Regular')
      expect(hash['instrument_data']['allow_partial_match']).to be(true)
      # company_name and type are declared on the update account holder but not the
      # store one.
      expect(hash['account_holder']['company_name']).to eq('Checkout.com')
      expect(hash['account_holder']['type']).to eq('corporate')
      expect(hash['account_holder']['billing_address']['city']).to eq('London')
    end
  end

  describe 'the Bacs and SEPA payment_type casing split' do
    it 'keeps Bacs capitalized and SEPA lowercase' do
      # Regression guard. The specification declares Bacs payment_type as
      # Recurring / Regular capitalized and SEPA payment_type as recurring / regular
      # lowercase. The two are not interchangeable and must never be unified.
      expect(CheckoutSdk::Instruments::BacsPaymentType::RECURRING).to eq('Recurring')
      expect(CheckoutSdk::Instruments::BacsPaymentType::REGULAR).to eq('Regular')
      expect(CheckoutSdk::Instruments::SepaPaymentType::RECURRING).to eq('recurring')
      expect(CheckoutSdk::Instruments::SepaPaymentType::REGULAR).to eq('regular')

      expect(CheckoutSdk::Instruments::BacsPaymentType::RECURRING)
        .not_to eq(CheckoutSdk::Instruments::SepaPaymentType::RECURRING)
    end
  end
end
