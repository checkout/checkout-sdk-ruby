# frozen_string_literal: true

RSpec.describe 'Accounts API v3.0 serialization' do
  def serialize(object)
    CheckoutSdk::JsonSerializer.to_custom_hash(object)
  end

  it 'serializes ProcessingDetails with payments/ach' do
    ach = CheckoutSdk::Accounts::ProcessingDetailsAch.new
    ach.annual_ach_volume = 1_000_000
    ach.average_ach_transaction_size = 5_000
    ach.estimated_monthly_credit_volume = 100_000
    ach.average_credit_amount = 5_000
    payments = CheckoutSdk::Accounts::ProcessingDetailsPayments.new
    payments.ach = ach
    details = CheckoutSdk::Accounts::ProcessingDetails.new
    details.annual_processing_volume = 1_000_000
    details.average_order_fulfillment_time = 3
    details.highest_transaction_value = 25_000
    details.currency = CheckoutSdk::Common::Currency::GBP
    details.settlement_country = 'GB'
    details.target_countries = ['GB']
    details.payments = payments

    hash = serialize(details)

    expect(hash['average_order_fulfillment_time']).to eq(3)
    expect(hash['payments']['ach']['annual_ach_volume']).to eq(1_000_000)
    expect(hash['payments']['ach']['average_ach_transaction_size']).to eq(5_000)
    expect(hash['payments']['ach']['estimated_monthly_credit_volume']).to eq(100_000)
    expect(hash['payments']['ach']['average_credit_amount']).to eq(5_000)
  end

  it 'serializes AgreedTerms' do
    agreed = CheckoutSdk::Accounts::AgreedTerms.new
    agreed.date = '2026-07-20T10:00:00Z'
    agreed.ip_address = '203.0.113.42'
    agreed.name = 'John Representative'
    agreed.email = 'john@example.com'
    agreed.version = '1.0'

    hash = serialize(agreed)

    expect(hash['date']).to eq('2026-07-20T10:00:00Z')
    expect(hash['ip_address']).to eq('203.0.113.42')
    expect(hash['name']).to eq('John Representative')
    expect(hash['email']).to eq('john@example.com')
    expect(hash['version']).to eq('1.0')
  end

  it 'serializes Company v3.0 fields' do
    doi = CheckoutSdk::Accounts::DateOfIncorporation.new
    doi.day = 1
    doi.month = 6
    doi.year = 2010
    company = CheckoutSdk::Accounts::Company.new
    company.legal_name = 'Super Hero Masks Inc.'
    company.business_type = CheckoutSdk::Accounts::BusinessType::LIMITED_COMPANY
    company.additional_trading_names = ['SHM']
    company.is_registered_company = true
    company.date_of_incorporation = doi

    hash = serialize(company)

    expect(hash['additional_trading_names']).to eq(['SHM'])
    expect(hash['is_registered_company']).to eq(true)
    expect(hash['business_type']).to eq('limited_company')
    expect(hash['date_of_incorporation']).to eq('day' => 1, 'month' => 6, 'year' => 2010)
  end

  it 'serializes a v3.0 Representative with nested individual, citizenships and national_id_type' do
    citizenship = CheckoutSdk::Accounts::Citizenship.new
    citizenship.type = 'citizenship'
    citizenship.country = CheckoutSdk::Common::Country::US
    individual = CheckoutSdk::Accounts::RepresentativeIndividual.new
    individual.first_name = 'John'
    individual.last_name = 'Doe'
    individual.citizenships = [citizenship]
    individual.national_id_type = CheckoutSdk::Accounts::NationalIdType::SSN
    individual.national_id_number = 'AB123456C'
    representative = CheckoutSdk::Accounts::Representative.new
    representative.individual = individual
    representative.company_position = CheckoutSdk::Accounts::CompanyPosition::CEO
    representative.ownership_percentage = 100
    representative.roles = [
      CheckoutSdk::Accounts::EntityRoles::UBO,
      CheckoutSdk::Accounts::EntityRoles::AUTHORISED_SIGNATORY,
      CheckoutSdk::Accounts::EntityRoles::DIRECTOR,
      CheckoutSdk::Accounts::EntityRoles::CONTROL_PERSON
    ]

    hash = serialize(representative)

    expect(hash['company_position']).to eq('ceo')
    expect(hash['ownership_percentage']).to eq(100)
    expect(hash['roles']).to eq(%w[ubo authorised_signatory director control_person])
    expect(hash['individual']['national_id_type']).to eq('ssn')
    expect(hash['individual']['citizenships']).to eq([{ 'type' => 'citizenship', 'country' => 'US' }])
  end

  it 'serializes the financial_statements document' do
    fs = CheckoutSdk::Accounts::FinancialStatements.new
    fs.type = CheckoutSdk::Accounts::FinancialStatementsType::FINANCIAL_STATEMENTS
    fs.front = 'file_00000000000000000000000000'
    documents = CheckoutSdk::Accounts::OnboardSubEntityDocuments.new
    documents.financial_statements = fs

    hash = serialize(documents)

    expect(hash['financial_statements']).to eq('type' => 'financial_statements',
                                               'front' => 'file_00000000000000000000000000')
  end

  it 'exposes the complete enum value sets' do
    expect(CheckoutSdk::Accounts::BusinessType.constants.size).to eq(19)
    expect(CheckoutSdk::Accounts::EntityRoles.constants.size).to eq(5)
    expect(CheckoutSdk::Accounts::CompanyPosition.constants.size).to eq(11)
    expect(CheckoutSdk::Accounts::NationalIdType.constants.size).to eq(7)
  end
end
