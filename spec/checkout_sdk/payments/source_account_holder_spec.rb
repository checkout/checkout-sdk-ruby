# frozen_string_literal: true

RSpec.describe 'Dedicated payment-source account holders' do
  describe CheckoutSdk::Payments::SepaSourceAccountHolder do
    it 'declares exactly the five properties the schema declares' do
      holder = described_class.new
      holder.first_name = 'John'
      holder.last_name = 'Wick'
      holder.company_name = 'Checkout.com'
      holder.type = CheckoutSdk::Instruments::InstrumentAccountHolderType::INDIVIDUAL
      holder.billing_address = CheckoutSdk::Payments::SepaSourceBillingAddress.new

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(holder)

      expect(hash.keys.sort).to eq(%w[billing_address company_name first_name last_name type])
    end

    it 'is narrower than the shared AccountHolder it replaced' do
      # Common::AccountHolder carries 16 properties; this position declares 5.
      shared = CheckoutSdk::Common::AccountHolder.new
      %i[type full_name first_name middle_name last_name email gender company_name tax_id
         date_of_birth country_of_birth residential_status billing_address phone
         identification account_name_inquiry].each { |a| shared.public_send("#{a}=", 'x') }

      shared_keys = CheckoutSdk::JsonSerializer.to_custom_hash(shared).keys

      expect(shared_keys.length).to eq(16)
      expect(described_class.new.methods).not_to include(:tax_id=, :gender=, :phone=)
    end
  end

  describe CheckoutSdk::Payments::SepaSourceBillingAddress do
    it 'declares the five required properties and not state' do
      address = described_class.new
      address.address_line1 = 'Evergreen Terrace'
      address.address_line2 = '742'
      address.city = 'Paris'
      address.zip = '75000'
      address.country = CheckoutSdk::Common::Country::FR

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(address)

      expect(hash.keys.sort).to eq(%w[address_line1 address_line2 city country zip])
      # Common::Address also declares state, which this position does not accept.
      expect(described_class.new.methods).not_to include(:state=)
      expect(CheckoutSdk::Common::Address.new.methods).to include(:state=)
    end
  end

  describe CheckoutSdk::Payments::AchSourceAccountHolder do
    it 'declares exactly the seven properties AccountHolderAch declares' do
      holder = described_class.new
      holder.type = CheckoutSdk::Common::AccountHolderType::CORPORATE
      holder.first_name = 'John'
      holder.last_name = 'Smith'
      holder.company_name = 'Checkout.com'
      holder.date_of_birth = '1996-05-05'
      holder.billing_address = CheckoutSdk::Common::Address.new
      holder.identification = CheckoutSdk::Common::AccountHolderIdentification.new

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(holder)

      expect(hash.keys.sort).to eq(%w[billing_address company_name date_of_birth first_name
                                      identification last_name type])
      expect(described_class.new.methods).not_to include(:tax_id=, :gender=, :phone=)
    end
  end

  describe 'wiring into the sources' do
    it 'serializes a SEPA source built from the dedicated types' do
      address = CheckoutSdk::Payments::SepaSourceBillingAddress.new
      address.address_line1 = 'Evergreen Terrace'
      address.address_line2 = '742'
      address.city = 'Paris'
      address.zip = '75000'
      address.country = CheckoutSdk::Common::Country::FR

      holder = CheckoutSdk::Payments::SepaSourceAccountHolder.new
      holder.first_name = 'John'
      holder.last_name = 'Wick'
      holder.type = CheckoutSdk::Instruments::InstrumentAccountHolderType::INDIVIDUAL
      holder.billing_address = address

      source = CheckoutSdk::Payments::SepaSource.new
      source.country = CheckoutSdk::Common::Country::FR
      source.account_number = 'FR7630006000011234567890189'
      source.currency = CheckoutSdk::Common::Currency::EUR
      source.account_holder = holder

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(source)

      expect(hash['type']).to eq('sepa')
      expect(hash['account_holder']['type']).to eq('individual')
      expect(hash['account_holder']['billing_address']['city']).to eq('Paris')
      expect(hash['account_holder']['billing_address']).not_to have_key('state')
    end

    it 'serializes an ACH source built from the dedicated types' do
      holder = CheckoutSdk::Payments::AchSourceAccountHolder.new
      holder.type = CheckoutSdk::Common::AccountHolderType::INDIVIDUAL
      holder.first_name = 'John'
      holder.last_name = 'Smith'

      source = CheckoutSdk::Payments::AchSource.new
      source.account_type = CheckoutSdk::Payments::AchSourceAccountType::CHECKING
      source.country = CheckoutSdk::Common::Country::US
      source.account_number = '136549956'
      source.bank_code = '021000021'
      source.account_holder = holder

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(source)

      expect(hash['type']).to eq('ach')
      expect(hash['account_type']).to eq('checking')
      expect(hash['account_holder']).to eq({ 'type' => 'individual',
                                             'first_name' => 'John',
                                             'last_name' => 'Smith' })
    end

    it 'still accepts the shared AccountHolder and a Hash, so no caller breaks' do
      # Ruby is duck-typed: retargeting the documented type is not a runtime change.
      legacy = CheckoutSdk::Common::AccountHolder.new
      legacy.first_name = 'John'
      legacy.last_name = 'Wick'

      source = CheckoutSdk::Payments::SepaSource.new
      source.account_holder = legacy
      expect(CheckoutSdk::JsonSerializer.to_custom_hash(source)['account_holder'])
        .to eq({ 'first_name' => 'John', 'last_name' => 'Wick' })

      hash_source = CheckoutSdk::Payments::AchSource.new
      hash_source.account_holder = { 'first_name' => 'John' }
      expect(CheckoutSdk::JsonSerializer.to_custom_hash(hash_source)['account_holder'])
        .to eq({ 'first_name' => 'John' })
    end
  end
end
