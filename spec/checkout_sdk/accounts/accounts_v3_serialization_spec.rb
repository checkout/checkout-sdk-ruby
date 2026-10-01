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

  # Regression: EEA Sole Trader (3.0) needs proof_of_residential_address and proof_of_registration on
  # the representative, with bank_verification alone at the top level. Neither could be expressed before.
  it 'serializes the EEA Sole Trader representative documents' do
    identity = CheckoutSdk::Accounts::Document.new
    identity.type = CheckoutSdk::Accounts::DocumentType::PASSPORT
    identity.front = 'file_identityverificationaaaaaa'
    residential = CheckoutSdk::Accounts::ProofOfResidentialAddress.new
    residential.type = CheckoutSdk::Accounts::ProofOfResidentialAddressType::PROOF_OF_ADDRESS
    residential.front = 'file_proofofresidentialaddressa'
    registration = CheckoutSdk::Accounts::ProofOfRegistration.new
    registration.type = CheckoutSdk::Accounts::ProofOfRegistrationType::EXTRACT_FROM_TRADE_REGISTER
    registration.front = 'file_proofofregistrationaaaaaaa'
    rep_documents = CheckoutSdk::Accounts::RepresentativeDocuments.new
    rep_documents.identity_verification = identity
    rep_documents.proof_of_residential_address = residential
    rep_documents.proof_of_registration = registration
    representative = CheckoutSdk::Accounts::Representative.new
    representative.roles = [CheckoutSdk::Accounts::EntityRoles::UBO]
    representative.documents = rep_documents
    company = CheckoutSdk::Accounts::Company.new
    company.business_type = CheckoutSdk::Accounts::BusinessType::INDIVIDUAL_OR_SOLE_PROPRIETORSHIP
    company.representatives = [representative]
    bank = CheckoutSdk::Accounts::BankVerification.new
    bank.type = CheckoutSdk::Accounts::BankVerificationType::BANK_STATEMENT
    bank.front = 'file_bankverificationaaaaaaaaaa'
    documents = CheckoutSdk::Accounts::OnboardSubEntityDocuments.new
    documents.bank_verification = bank
    request = CheckoutSdk::Accounts::OnboardEntity.new
    request.reference = 'ref_sole_trader'
    request.company = company
    request.documents = documents

    hash = serialize(request)

    expect(hash['company']['representatives'][0]['documents']).to eq(
      'identity_verification' => { 'type' => 'passport', 'front' => 'file_identityverificationaaaaaa' },
      'proof_of_residential_address' => { 'type' => 'proof_of_address', 'front' => 'file_proofofresidentialaddressa' },
      'proof_of_registration' => { 'type' => 'extract_from_trade_register', 'front' => 'file_proofofregistrationaaaaaaa' }
    )
    expect(hash['documents']).to eq(
      'bank_verification' => { 'type' => 'bank_statement', 'front' => 'file_bankverificationaaaaaaaaaa' }
    )
    # Key-level check on the JSON body, so a naming change cannot pass silently.
    body = hash.to_json
    expect(body).to include('"proof_of_residential_address":{')
    expect(body).to include('"proof_of_registration":{')
  end

  # The API rejects any key on company.representatives[].documents other than these four
  # (additionalProperties: false), so an attribute added here by mistake would fail the request.
  it 'declares only the representative document keys the API accepts' do
    setters = CheckoutSdk::Accounts::RepresentativeDocuments.public_instance_methods(false).grep(/=$/)
    expect(setters.map { |m| m.to_s.chomp('=') }).to contain_exactly(
      'identity_verification', 'certified_authorised_signatory', 'proof_of_residential_address', 'proof_of_registration'
    )
  end

  it 'serializes the certified authorised signatory with type and front only' do
    signatory = CheckoutSdk::Accounts::CertifiedAuthorisedSignatory.new
    signatory.type = CheckoutSdk::Accounts::CertifiedAuthorisedSignatoryType::POWER_OF_ATTORNEY
    signatory.front = 'file_signatoryaaaaaaaaaaaaaaaaa'
    documents = CheckoutSdk::Accounts::RepresentativeDocuments.new
    documents.certified_authorised_signatory = signatory

    expect(serialize(documents)).to eq(
      'certified_authorised_signatory' => { 'type' => 'power_of_attorney', 'front' => 'file_signatoryaaaaaaaaaaaaaaaaa' }
    )
  end

  # Unset attributes are omitted; an attribute assigned nil is sent as null.
  it 'omits unset representative documents and sends nil as null' do
    registration = CheckoutSdk::Accounts::ProofOfRegistration.new
    registration.type = CheckoutSdk::Accounts::ProofOfRegistrationType::OTHER
    registration.front = 'file_proofofregistrationaaaaaaa'
    documents = CheckoutSdk::Accounts::RepresentativeDocuments.new
    documents.proof_of_registration = registration

    expect(serialize(documents)).to eq(
      'proof_of_registration' => { 'type' => 'other', 'front' => 'file_proofofregistrationaaaaaaa' }
    )
    documents.identity_verification = nil
    expect(serialize(documents)).to include('identity_verification' => nil)
  end

  # Every attribute of OnboardSubEntityDocuments, so a naming change on any key cannot pass silently.
  it 'serializes every top-level documents attribute' do
    file = 'file_aaaaaaaaaaaaaaaaaaaaaaaaaa'
    build = lambda do |klass, type = nil|
      document = klass.new
      document.type = type unless type.nil?
      document.front = file
      document
    end
    a = CheckoutSdk::Accounts
    documents = a::OnboardSubEntityDocuments.new
    documents.identity_verification = build.call(a::Document, a::DocumentType::PASSPORT)
    documents.company_verification = build.call(a::CompanyVerification, a::CompanyVerificationType::INCORPORATION_DOCUMENT)
    documents.articles_of_association = build.call(a::ArticlesOfAssociation,
                                                   a::ArticlesOfAssociationType::ARTICLES_OF_ASSOCIATION)
    documents.bank_verification = build.call(a::BankVerification, a::BankVerificationType::BANK_STATEMENT)
    documents.shareholder_structure = build.call(a::ShareholderStructure,
                                                 a::ShareholderStructureType::CERTIFIED_SHAREHOLDER_STRUCTURE)
    documents.proof_of_legality = build.call(a::ProofOfLegality, a::ProofOfLegalityType::PROOF_OF_LEGALITY)
    documents.proof_of_principal_address = build.call(a::ProofOfPrincipalAddress,
                                                      a::ProofOfPrincipalAddressType::PROOF_OF_ADDRESS)
    documents.additional_document1 = build.call(a::AdditionalDocument)
    documents.additional_document2 = build.call(a::AdditionalDocument)
    documents.additional_document3 = build.call(a::AdditionalDocument)
    documents.tax_verification = build.call(a::TaxVerification, a::TaxVerificationType::EIN_LETTER)
    documents.financial_verification = build.call(a::FinancialVerification,
                                                  a::FinancialVerificationType::FINANCIAL_STATEMENT)
    documents.financial_statements = build.call(a::FinancialStatements,
                                                a::FinancialStatementsType::FINANCIAL_STATEMENTS)

    expect(serialize(documents)).to eq(
      'identity_verification' => { 'type' => 'passport', 'front' => file },
      'company_verification' => { 'type' => 'incorporation_document', 'front' => file },
      'articles_of_association' => { 'type' => 'articles_of_association', 'front' => file },
      'bank_verification' => { 'type' => 'bank_statement', 'front' => file },
      'shareholder_structure' => { 'type' => 'certified_shareholder_structure', 'front' => file },
      'proof_of_legality' => { 'type' => 'proof_of_legality', 'front' => file },
      'proof_of_principal_address' => { 'type' => 'proof_of_address', 'front' => file },
      'additional_document1' => { 'front' => file },
      'additional_document2' => { 'front' => file },
      'additional_document3' => { 'front' => file },
      'tax_verification' => { 'type' => 'ein_letter', 'front' => file },
      'financial_verification' => { 'type' => 'financial_statement', 'front' => file },
      'financial_statements' => { 'type' => 'financial_statements', 'front' => file }
    )
  end

  # Regression: both classes declared attr_reader only, so setting either attribute raised NoMethodError.
  it 'allows setting ProofOfPrincipalAddress and FinancialVerification' do
    address = CheckoutSdk::Accounts::ProofOfPrincipalAddress.new
    address.type = CheckoutSdk::Accounts::ProofOfPrincipalAddressType::PROOF_OF_ADDRESS
    address.front = 'file_aaaaaaaaaaaaaaaaaaaaaaaaaa'
    verification = CheckoutSdk::Accounts::FinancialVerification.new
    verification.type = CheckoutSdk::Accounts::FinancialVerificationType::FINANCIAL_STATEMENT
    verification.front = 'file_aaaaaaaaaaaaaaaaaaaaaaaaaa'

    expect(serialize(address)).to eq('type' => 'proof_of_address', 'front' => 'file_aaaaaaaaaaaaaaaaaaaaaaaaaa')
    expect(serialize(verification)).to eq('type' => 'financial_statement', 'front' => 'file_aaaaaaaaaaaaaaaaaaaaaaaaaa')
  end

  # EEA and GB Company Full (3.0) allow a representative that is a company:
  # { company: { legal_name, trading_name, registered_address }, ownership_percentage }.
  it 'serializes a controlling company representative' do
    address = CheckoutSdk::Common::Address.new
    address.address_line1 = '1 Main Street'
    address.city = 'London'
    address.zip = 'W1T 4TJ'
    address.country = CheckoutSdk::Common::Country::GB
    company = CheckoutSdk::Accounts::Company.new
    company.legal_name = 'Parent Holdings Ltd'
    company.trading_name = 'Parent Holdings'
    company.registered_address = address
    representative = CheckoutSdk::Accounts::Representative.new
    representative.company = company
    representative.ownership_percentage = 60

    expect(serialize(representative)).to eq(
      'company' => {
        'legal_name' => 'Parent Holdings Ltd',
        'trading_name' => 'Parent Holdings',
        'registered_address' => { 'address_line1' => '1 Main Street', 'city' => 'London', 'zip' => 'W1T 4TJ',
                                  'country' => 'GB' }
      },
      'ownership_percentage' => 60
    )
  end

  it 'serializes the v2.0 representative middle name' do
    representative = CheckoutSdk::Accounts::Representative.new
    representative.first_name = 'John'
    representative.middle_name = 'Paul'
    representative.last_name = 'Doe'

    expect(serialize(representative)).to eq('first_name' => 'John', 'middle_name' => 'Paul', 'last_name' => 'Doe')
  end

  # upload_file and upload_entity_file send the purpose value on the wire.
  it 'exposes every onboarding upload purpose' do
    purpose = CheckoutSdk::Accounts::FilePurpose
    expect(purpose.constants.map { |c| purpose.const_get(c) }).to contain_exactly(
      'additional_document', 'articles_of_association', 'bank_verification', 'certified_authorised_signatory',
      'company_ownership', 'company_verification', 'financial_verification', 'identity_verification',
      'proof_of_legality', 'proof_of_principal_address', 'shareholder_structure', 'tax_verification',
      'proof_of_residential_address', 'proof_of_registration'
    )
  end

  it 'exposes the representative document types' do
    expect(CheckoutSdk::Accounts::ProofOfResidentialAddressType::PROOF_OF_ADDRESS).to eq('proof_of_address')
    expect(CheckoutSdk::Accounts::ProofOfRegistrationType::EXTRACT_FROM_TRADE_REGISTER).to eq('extract_from_trade_register')
    expect(CheckoutSdk::Accounts::ProofOfRegistrationType::OTHER).to eq('other')
    expect(CheckoutSdk::Accounts::CertifiedAuthorisedSignatoryType::POWER_OF_ATTORNEY).to eq('power_of_attorney')
  end
end
