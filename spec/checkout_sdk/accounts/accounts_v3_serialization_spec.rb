# frozen_string_literal: true

RSpec.describe 'Accounts API v3.0 serialization' do
  def serialize(object)
    CheckoutSdk::JsonSerializer.to_custom_hash(object)
  end

  # US ISV Seller (3.0) processing details: payments and average_order_fulfillment_time, and no
  # settlement_country or highest_transaction_value.
  it 'serializes the US ISV Seller ProcessingDetails with payments/ach' do
    expect(serialize(isv_processing_details)).to eq(
      'annual_processing_volume' => 1000,
      'average_transaction_value' => 2000,
      'average_order_fulfillment_time' => 3,
      'target_countries' => ['US'],
      'currency' => 'USD',
      'payments' => {
        'ach' => {
          'annual_ach_volume' => 100_000,
          'average_ach_transaction_size' => 5000,
          'estimated_monthly_credit_volume' => 50_000,
          'average_credit_amount' => 2500
        }
      }
    )
  end

  # EEA, GB and US Company Full and Sole Trader Full (3.0) processing details.
  it 'serializes the Full (3.0) ProcessingDetails with settlement_country and highest_transaction_value' do
    details = CheckoutSdk::Accounts::ProcessingDetails.new
    details.settlement_country = CheckoutSdk::Common::Country::GB
    details.target_countries = [CheckoutSdk::Common::Country::GB, CheckoutSdk::Common::Country::FR]
    details.annual_processing_volume = 1_000_000
    details.average_transaction_value = 2_000
    details.highest_transaction_value = 25_000
    details.currency = CheckoutSdk::Common::Currency::GBP

    expect(serialize(details)).to eq(
      'settlement_country' => 'GB',
      'target_countries' => %w[GB FR],
      'annual_processing_volume' => 1_000_000,
      'average_transaction_value' => 2_000,
      'highest_transaction_value' => 25_000,
      'currency' => 'GBP'
    )
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

  # is_registered_company exists only on US ISV Seller Sole Trader (3.0), where the only allowed value is false.
  it 'serializes the US ISV Seller Sole Trader Company fields' do
    doi = CheckoutSdk::Accounts::DateOfIncorporation.new
    doi.day = 1
    doi.month = 6
    doi.year = 2010
    company = CheckoutSdk::Accounts::Company.new
    company.business_type = CheckoutSdk::Accounts::BusinessType::INDIVIDUAL_OR_SOLE_PROPRIETORSHIP
    company.trading_name = 'Super Hero Masks'
    company.additional_trading_names = ['SHM']
    company.is_registered_company = false
    company.date_of_incorporation = doi

    expect(serialize(company)).to eq(
      'business_type' => 'individual_or_sole_proprietorship',
      'trading_name' => 'Super Hero Masks',
      'additional_trading_names' => ['SHM'],
      'is_registered_company' => false,
      'date_of_incorporation' => { 'day' => 1, 'month' => 6, 'year' => 2010 }
    )
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
    individual.national_id_number = '123456789'
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
    fs.front = 'file_yys6klxrua2y5cwgvudd2frkro'
    documents = CheckoutSdk::Accounts::OnboardSubEntityDocuments.new
    documents.financial_statements = fs

    hash = serialize(documents)

    expect(hash['financial_statements']).to eq('type' => 'financial_statements',
                                               'front' => 'file_yys6klxrua2y5cwgvudd2frkro')
  end

  # Value sets checked against the union of every onboarding variant in the spec.
  it 'exposes the complete enum value sets' do
    a = CheckoutSdk::Accounts
    values = ->(mod) { mod.constants.map { |c| mod.const_get(c) } }
    expect(values.call(a::DocumentType)).to contain_exactly(
      'passport', 'national_identity_card', 'driving_license', 'citizen_card', 'residence_permit', 'electoral_id'
    )
    expect(values.call(a::CompanyVerificationType)).to contain_exactly('incorporation_document',
                                                                       'articles_of_association')
    expect(values.call(a::ArticlesOfAssociationType)).to contain_exactly('memorandum_of_association',
                                                                         'articles_of_association')
    expect(values.call(a::BusinessType)).to contain_exactly(
      'individual_or_sole_proprietorship', 'general_partnership', 'limited_partnership',
      'scottish_limited_partnership', 'public_limited_company', 'limited_company', 'limited_liability_corporation',
      'private_corporation', 'publicly_traded_corporation', 'professional_association', 'unincorporated_association',
      'auto_entrepreneur', 'government_agency', 'non_profit_entity', 'trust', 'club_or_society',
      'regulated_financial_institution', 'cftc_registered_entity', 'sec_registered_entity'
    )
    expect(values.call(a::CompanyPosition)).to contain_exactly(
      'ceo', 'cfo', 'coo', 'managing_member', 'general_partner', 'president', 'vice_president', 'treasurer',
      'other_senior_management', 'other_executive_officer', 'other_non_executive_non_senior'
    )
    expect(values.call(a::NationalIdType)).to contain_exactly(
      'ssn', 'itin', 'passport', 'driving_license', 'national_id_card', 'residence_permit', 'other'
    )
    expect(values.call(a::EntityRoles)).to contain_exactly(
      'ubo', 'legal_representative', 'authorised_signatory', 'director', 'control_person'
    )
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
      'proof_of_registration' => { 'type' => 'extract_from_trade_register',
                                   'front' => 'file_proofofregistrationaaaaaaa' }
    )
    expect(hash['documents']).to eq(
      'bank_verification' => { 'type' => 'bank_statement', 'front' => 'file_bankverificationaaaaaaaaaa' }
    )
    # Key-level check on the JSON body, so a naming change cannot pass silently.
    body = hash.to_json
    expect(body).to include('"proof_of_residential_address":{')
    expect(body).to include('"proof_of_registration":{')
  end

  # On the EEA, GB and US Company Full (3.0) and Sole Trader Full (3.0) variants the API rejects any key
  # on company.representatives[].documents it does not define (additionalProperties: false), so an
  # attribute added here by mistake would fail the request.
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
      'certified_authorised_signatory' => { 'type' => 'power_of_attorney',
                                            'front' => 'file_signatoryaaaaaaaaaaaaaaaaa' }
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
    documents.company_verification = build.call(a::CompanyVerification,
                                                a::CompanyVerificationType::INCORPORATION_DOCUMENT)
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

  # The US ISV Seller variants (3.0) require both addresses.
  it 'serializes the US ISV Seller email addresses with the PCI compliance contact' do
    email_addresses = CheckoutSdk::Accounts::EntityEmailAddresses.new
    email_addresses.primary = 'admin@example.com'
    email_addresses.pci_compliance_contact = 'pci@example.com'

    expect(serialize(email_addresses)).to eq('primary' => 'admin@example.com',
                                             'pci_compliance_contact' => 'pci@example.com')
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
    expect(CheckoutSdk::Accounts::ProofOfRegistrationType::EXTRACT_FROM_TRADE_REGISTER)
      .to eq('extract_from_trade_register')
    expect(CheckoutSdk::Accounts::ProofOfRegistrationType::OTHER).to eq('other')
    expect(CheckoutSdk::Accounts::CertifiedAuthorisedSignatoryType::POWER_OF_ATTORNEY).to eq('power_of_attorney')
  end

  def isv_address
    address = CheckoutSdk::Common::Address.new
    address.address_line1 = '123 Main Street'
    address.city = 'San Francisco'
    address.state = 'CA'
    address.zip = '94105'
    address.country = CheckoutSdk::Common::Country::US
    address
  end

  def isv_representative_individual(first_name, last_name, national_id_number, birth, phone_number)
    a = CheckoutSdk::Accounts
    individual = a::RepresentativeIndividual.new
    individual.first_name = first_name
    individual.last_name = last_name
    individual.email_address = "#{first_name.downcase}.#{last_name.downcase}@example.com"
    individual.national_id_type = a::NationalIdType::SSN
    individual.national_id_number = national_id_number
    individual.date_of_birth = a::DateOfBirth.new
    individual.date_of_birth.day, individual.date_of_birth.month, individual.date_of_birth.year = birth
    individual.place_of_birth = a::PlaceOfBirth.new
    individual.place_of_birth.country = CheckoutSdk::Common::Country::US
    individual.citizenships = [a::Citizenship.new]
    individual.citizenships[0].country = CheckoutSdk::Common::Country::US
    individual.phone = a::Phone.new
    individual.phone.country_code = CheckoutSdk::Common::Country::US
    individual.phone.number = phone_number
    individual.address = isv_address
    individual
  end

  def isv_processing_details
    a = CheckoutSdk::Accounts
    details = a::ProcessingDetails.new
    details.annual_processing_volume = 1000
    details.average_transaction_value = 2000
    details.average_order_fulfillment_time = 3
    details.target_countries = [CheckoutSdk::Common::Country::US]
    details.currency = CheckoutSdk::Common::Currency::USD
    details.payments = a::ProcessingDetailsPayments.new
    details.payments.ach = a::ProcessingDetailsAch.new
    details.payments.ach.annual_ach_volume = 100_000
    details.payments.ach.average_ach_transaction_size = 5000
    details.payments.ach.estimated_monthly_credit_volume = 50_000
    details.payments.ach.average_credit_amount = 2500
    details
  end

  # Everything the two US ISV Seller (3.0) swagger examples share apart from the company.
  def isv_onboard_entity(reference, signer_name, primary_email, url)
    a = CheckoutSdk::Accounts
    request = a::OnboardEntity.new
    request.reference = reference
    request.agreed_terms = a::AgreedTerms.new
    request.agreed_terms.date = '2026-07-02T10:30:00.0000000+00:00'
    request.agreed_terms.ip_address = '8.8.8.8'
    request.agreed_terms.name = signer_name
    request.agreed_terms.email = primary_email
    request.agreed_terms.version = 'cko-platform-terms-1.0.0'
    request.seller_category = 'cat_retail_001'
    request.processing_details = isv_processing_details
    request.contact_details = a::ContactDetails.new
    request.contact_details.phone = a::Phone.new
    request.contact_details.phone.number = '4155678900'
    request.contact_details.phone.country_code = CheckoutSdk::Common::Country::US
    request.contact_details.email_addresses = a::EntityEmailAddresses.new
    request.contact_details.email_addresses.primary = primary_email
    request.contact_details.email_addresses.pci_compliance_contact = 'pci.contact@example.com'
    request.profile = a::Profile.new
    request.profile.urls = [url]
    request.profile.mccs = ['5551']
    request.profile.holding_currencies = [CheckoutSdk::Common::Currency::USD]
    request.profile.default_holding_currency = CheckoutSdk::Common::Currency::USD
    request
  end

  def date_of_incorporation(day, month, year)
    doi = CheckoutSdk::Accounts::DateOfIncorporation.new
    doi.day = day
    doi.month = month
    doi.year = year
    doi
  end

  # The USISVSellerCompany3-0 swagger example, verbatim.
  it 'serializes the US ISV Seller Company (3.0) swagger example' do
    payload = JSON.parse(<<~JSON)
      {
        "reference": "isv-seller-example001",
        "agreed_terms": {
          "date": "2026-07-02T10:30:00.0000000+00:00",
          "ip_address": "8.8.8.8",
          "name": "Toby Arden",
          "email": "toby.arden@example.com",
          "version": "cko-platform-terms-1.0.0"
        },
        "seller_category": "cat_retail_001",
        "processing_details": {
          "annual_processing_volume": 1000,
          "average_transaction_value": 2000,
          "average_order_fulfillment_time": 3,
          "target_countries": ["US"],
          "currency": "USD",
          "payments": {
            "ach": {
              "annual_ach_volume": 100000,
              "average_ach_transaction_size": 5000,
              "estimated_monthly_credit_volume": 50000,
              "average_credit_amount": 2500
            }
          }
        },
        "contact_details": {
          "phone": {"number": "4155678900", "country_code": "US"},
          "email_addresses": {
            "primary": "toby.arden@example.com",
            "pci_compliance_contact": "pci.contact@example.com"
          }
        },
        "profile": {
          "urls": ["https://www.isv-seller-example.com"],
          "mccs": ["5551"],
          "holding_currencies": ["USD"],
          "default_holding_currency": "USD"
        },
        "company": {
          "business_registration_number": "12-3456789",
          "business_type": "private_corporation",
          "legal_name": "ISV Seller Example Inc",
          "trading_name": "ISV Seller Example",
          "registered_address": {
            "address_line1": "123 Main Street",
            "city": "San Francisco",
            "state": "CA",
            "zip": "94105",
            "country": "US"
          },
          "principal_address": {
            "address_line1": "123 Main Street",
            "city": "San Francisco",
            "state": "CA",
            "zip": "94105",
            "country": "US"
          },
          "date_of_incorporation": {"year": 2025, "month": 10, "day": 1},
          "representatives": [
            {
              "roles": ["ubo", "control_person"],
              "ownership_percentage": 25,
              "company_position": "ceo",
              "individual": {
                "first_name": "Toby",
                "last_name": "Arden",
                "email_address": "toby.arden@example.com",
                "national_id_type": "ssn",
                "national_id_number": "123456789",
                "date_of_birth": {"day": 15, "month": 1, "year": 1990},
                "place_of_birth": {"country": "US"},
                "citizenships": [{"country": "US"}],
                "phone": {"country_code": "US", "number": "4155678901"},
                "address": {
                  "address_line1": "123 Main Street",
                  "city": "San Francisco",
                  "state": "CA",
                  "zip": "94105",
                  "country": "US"
                }
              }
            },
            {
              "roles": ["authorised_signatory"],
              "individual": {
                "first_name": "Alex",
                "last_name": "Morgan",
                "email_address": "alex.morgan@example.com",
                "national_id_type": "ssn",
                "national_id_number": "987654321",
                "date_of_birth": {"day": 22, "month": 6, "year": 1985},
                "place_of_birth": {"country": "US"},
                "citizenships": [{"country": "US"}],
                "phone": {"country_code": "US", "number": "4155678902"},
                "address": {
                  "address_line1": "123 Main Street",
                  "city": "San Francisco",
                  "state": "CA",
                  "zip": "94105",
                  "country": "US"
                }
              }
            }
          ]
        }
      }
    JSON
    a = CheckoutSdk::Accounts
    ceo = a::Representative.new
    ceo.roles = [a::EntityRoles::UBO, a::EntityRoles::CONTROL_PERSON]
    ceo.ownership_percentage = 25
    ceo.company_position = a::CompanyPosition::CEO
    ceo.individual = isv_representative_individual('Toby', 'Arden', '123456789', [15, 1, 1990], '4155678901')
    signatory = a::Representative.new
    signatory.roles = [a::EntityRoles::AUTHORISED_SIGNATORY]
    signatory.individual = isv_representative_individual('Alex', 'Morgan', '987654321', [22, 6, 1985], '4155678902')
    company = a::Company.new
    company.business_registration_number = '12-3456789'
    company.business_type = a::BusinessType::PRIVATE_CORPORATION
    company.legal_name = 'ISV Seller Example Inc'
    company.trading_name = 'ISV Seller Example'
    company.registered_address = isv_address
    company.principal_address = isv_address
    company.date_of_incorporation = date_of_incorporation(1, 10, 2025)
    company.representatives = [ceo, signatory]
    request = isv_onboard_entity('isv-seller-example001', 'Toby Arden', 'toby.arden@example.com',
                                 'https://www.isv-seller-example.com')
    request.company = company

    expect(JSON.parse(serialize(request).to_json)).to eq(payload)
  end

  # The USISVSellerSoleTrader3-0 swagger example, verbatim.
  it 'serializes the US ISV Seller Sole Trader (3.0) swagger example' do
    payload = JSON.parse(<<~JSON)
      {
        "reference": "isv-sole-trader-example001",
        "agreed_terms": {
          "date": "2026-07-02T10:30:00.0000000+00:00",
          "ip_address": "8.8.8.8",
          "name": "Hannah Bret",
          "email": "hannah.bret@example.com",
          "version": "cko-platform-terms-1.0.0"
        },
        "seller_category": "cat_retail_001",
        "processing_details": {
          "annual_processing_volume": 1000,
          "average_transaction_value": 2000,
          "average_order_fulfillment_time": 3,
          "target_countries": ["US"],
          "currency": "USD",
          "payments": {
            "ach": {
              "annual_ach_volume": 100000,
              "average_ach_transaction_size": 5000,
              "estimated_monthly_credit_volume": 50000,
              "average_credit_amount": 2500
            }
          }
        },
        "contact_details": {
          "phone": {"number": "4155678900", "country_code": "US"},
          "email_addresses": {
            "primary": "hannah.bret@example.com",
            "pci_compliance_contact": "pci.contact@example.com"
          }
        },
        "profile": {
          "urls": ["https://www.isv-sole-trader-example.com"],
          "mccs": ["5551"],
          "holding_currencies": ["USD"],
          "default_holding_currency": "USD"
        },
        "company": {
          "business_type": "individual_or_sole_proprietorship",
          "is_registered_company": false,
          "trading_name": "Hannah's Goods",
          "date_of_incorporation": {"year": 2025, "month": 10, "day": 1},
          "principal_address": {
            "address_line1": "123 Main Street",
            "city": "San Francisco",
            "state": "CA",
            "zip": "94105",
            "country": "US"
          },
          "representatives": [
            {
              "roles": ["ubo"],
              "ownership_percentage": 100,
              "individual": {
                "first_name": "Hannah",
                "last_name": "Bret",
                "email_address": "hannah.bret@example.com",
                "national_id_type": "ssn",
                "national_id_number": "123456789",
                "date_of_birth": {"day": 15, "month": 1, "year": 1990},
                "place_of_birth": {"country": "US"},
                "citizenships": [{"country": "US"}],
                "phone": {"country_code": "US", "number": "4155678901"},
                "address": {
                  "address_line1": "123 Main Street",
                  "city": "San Francisco",
                  "state": "CA",
                  "zip": "94105",
                  "country": "US"
                }
              }
            }
          ]
        }
      }
    JSON
    a = CheckoutSdk::Accounts
    owner = a::Representative.new
    owner.roles = [a::EntityRoles::UBO]
    owner.ownership_percentage = 100
    owner.individual = isv_representative_individual('Hannah', 'Bret', '123456789', [15, 1, 1990], '4155678901')
    company = a::Company.new
    company.business_type = a::BusinessType::INDIVIDUAL_OR_SOLE_PROPRIETORSHIP
    company.is_registered_company = false
    company.trading_name = "Hannah's Goods"
    company.date_of_incorporation = date_of_incorporation(1, 10, 2025)
    company.principal_address = isv_address
    company.representatives = [owner]
    request = isv_onboard_entity('isv-sole-trader-example001', 'Hannah Bret', 'hannah.bret@example.com',
                                 'https://www.isv-sole-trader-example.com')
    request.company = company

    expect(JSON.parse(serialize(request).to_json)).to eq(payload)
  end

  it 'serializes ContactDetails with phone, email addresses and invitee' do
    a = CheckoutSdk::Accounts
    contact = a::ContactDetails.new
    contact.phone = a::Phone.new
    contact.phone.country_code = CheckoutSdk::Common::Country::US
    contact.phone.number = '4155678900'
    contact.email_addresses = a::EntityEmailAddresses.new
    contact.email_addresses.primary = 'admin@example.com'
    contact.email_addresses.pci_compliance_contact = 'pci@example.com'
    contact.invitee = a::Invitee.new
    contact.invitee.email = 'invitee@example.com'

    expect(serialize(contact)).to eq(
      'phone' => { 'country_code' => 'US', 'number' => '4155678900' },
      'email_addresses' => { 'primary' => 'admin@example.com', 'pci_compliance_contact' => 'pci@example.com' },
      'invitee' => { 'email' => 'invitee@example.com' }
    )
  end

  # EEA Company Full (3.0) is the only variant with regulatory_licence_number.
  it 'serializes the EEA Company Full (3.0) Company fields and omits the deprecated document' do
    address = CheckoutSdk::Common::Address.new
    address.address_line1 = '1 Rue de Rivoli'
    address.city = 'Paris'
    address.zip = '75001'
    address.country = CheckoutSdk::Common::Country::FR
    company = CheckoutSdk::Accounts::Company.new
    company.business_registration_number = '552100554'
    company.business_type = CheckoutSdk::Accounts::BusinessType::LIMITED_COMPANY
    company.legal_name = 'Super Hero Masks SARL'
    company.trading_name = 'Super Hero Masks'
    company.principal_address = address
    company.registered_address = address
    company.regulatory_licence_number = 'LIC-12345'
    company.date_of_incorporation = date_of_incorporation(1, 6, 2010)

    hash = serialize(company)
    expected_address = { 'address_line1' => '1 Rue de Rivoli', 'city' => 'Paris', 'zip' => '75001', 'country' => 'FR' }
    expect(hash).to eq(
      'business_registration_number' => '552100554',
      'business_type' => 'limited_company',
      'legal_name' => 'Super Hero Masks SARL',
      'trading_name' => 'Super Hero Masks',
      'principal_address' => expected_address,
      'registered_address' => expected_address,
      'regulatory_licence_number' => 'LIC-12345',
      'date_of_incorporation' => { 'day' => 1, 'month' => 6, 'year' => 2010 }
    )
    expect(hash).not_to have_key('document')
  end

  # financial_details exists on the EEA and US Company Full and Lite (2.0) variants.
  it 'serializes the v2.0 Company financial_details with every EntityFinancialDetails field' do
    financial = CheckoutSdk::Accounts::EntityFinancialDetails.new
    financial.annual_processing_volume = 1_200_000
    financial.average_transaction_value = 5_000
    financial.highest_transaction_value = 25_000
    financial.currency = CheckoutSdk::Common::Currency::EUR
    company = CheckoutSdk::Accounts::Company.new
    company.legal_name = 'Super Hero Masks SARL'
    company.financial_details = financial

    expect(serialize(company)).to eq(
      'legal_name' => 'Super Hero Masks SARL',
      'financial_details' => {
        'annual_processing_volume' => 1_200_000,
        'average_transaction_value' => 5_000,
        'highest_transaction_value' => 25_000,
        'currency' => 'EUR'
      }
    )
  end

  it 'serializes every RepresentativeIndividual field' do
    a = CheckoutSdk::Accounts
    individual = isv_representative_individual('John', 'Doe', '123456789', [5, 5, 1990], '4155678901')
    individual.middle_name = 'Paul'
    individual.citizenships[0].type = 'citizenship'

    expect(serialize(individual)).to eq(
      'first_name' => 'John',
      'middle_name' => 'Paul',
      'last_name' => 'Doe',
      'date_of_birth' => { 'day' => 5, 'month' => 5, 'year' => 1990 },
      'place_of_birth' => { 'country' => 'US' },
      'citizenships' => [{ 'type' => 'citizenship', 'country' => 'US' }],
      'national_id_type' => 'ssn',
      'national_id_number' => '123456789',
      'email_address' => 'john.doe@example.com',
      'phone' => { 'country_code' => 'US', 'number' => '4155678901' },
      'address' => { 'address_line1' => '123 Main Street', 'city' => 'San Francisco', 'state' => 'CA',
                     'zip' => '94105', 'country' => 'US' }
    )
    expect(a::RepresentativeIndividual.public_instance_methods(false).grep(/=$/).size).to eq(11)
  end

  it 'serializes the v3.0 Representative id' do
    individual = CheckoutSdk::Accounts::RepresentativeIndividual.new
    individual.first_name = 'John'
    individual.last_name = 'Doe'
    representative = CheckoutSdk::Accounts::Representative.new
    representative.id = 'rep_6kr6pq3fbvtpjhrxmsrioxk52x'
    representative.individual = individual
    representative.roles = [CheckoutSdk::Accounts::EntityRoles::LEGAL_REPRESENTATIVE]

    expect(serialize(representative)).to eq(
      'id' => 'rep_6kr6pq3fbvtpjhrxmsrioxk52x',
      'individual' => { 'first_name' => 'John', 'last_name' => 'Doe' },
      'roles' => ['legal_representative']
    )
  end

  # identification is on the US Company (2.0) representative, place_of_birth on the EEA Company Full (2.0)
  # one; the v2.0 phone carries the number only.
  it 'serializes the remaining v2.0 Representative fields' do
    a = CheckoutSdk::Accounts
    birth = a::DateOfBirth.new
    birth.day = 5
    birth.month = 5
    birth.year = 1990
    phone = a::Phone.new
    phone.number = '4155678901'
    us = a::Representative.new
    us.address = isv_address
    us.identification = a::Identification.new
    us.identification.national_id_number = '123456789'
    us.phone = phone
    us.date_of_birth = birth
    eea = a::Representative.new
    eea.phone = phone
    eea.date_of_birth = birth
    eea.place_of_birth = a::PlaceOfBirth.new
    eea.place_of_birth.country = CheckoutSdk::Common::Country::FR

    expect(serialize(us)).to eq(
      'address' => { 'address_line1' => '123 Main Street', 'city' => 'San Francisco', 'state' => 'CA',
                     'zip' => '94105', 'country' => 'US' },
      'identification' => { 'national_id_number' => '123456789' },
      'phone' => { 'number' => '4155678901' },
      'date_of_birth' => { 'day' => 5, 'month' => 5, 'year' => 1990 }
    )
    expect(serialize(eea)).to eq(
      'phone' => { 'number' => '4155678901' },
      'date_of_birth' => { 'day' => 5, 'month' => 5, 'year' => 1990 },
      'place_of_birth' => { 'country' => 'FR' }
    )
  end

  # The nine v2.0 individual properties across the variants: identification and financial_details are
  # US Sole Trader (2.0) only, place_of_birth EEA Sole Trader (2.0) only.
  it 'serializes every v2.0 Individual field and omits the deprecated ones when unset' do
    a = CheckoutSdk::Accounts
    birth = a::DateOfBirth.new
    birth.day = 5
    birth.month = 5
    birth.year = 1990
    us = a::Individual.new
    us.first_name = 'John'
    us.middle_name = 'Paul'
    us.last_name = 'Doe'
    us.trading_name = 'John Doe Masks'
    us.registered_address = isv_address
    us.date_of_birth = birth
    us.identification = a::Identification.new
    us.identification.national_id_number = '123456789'
    us.financial_details = a::EntityFinancialDetails.new
    us.financial_details.annual_processing_volume = 120_000
    us.financial_details.average_transaction_value = 500
    us.financial_details.highest_transaction_value = 2_500
    us.financial_details.currency = CheckoutSdk::Common::Currency::USD
    eea = a::Individual.new
    eea.first_name = 'Jean'
    eea.last_name = 'Dupont'
    eea.place_of_birth = a::PlaceOfBirth.new
    eea.place_of_birth.country = CheckoutSdk::Common::Country::FR

    us_hash = serialize(us)

    expect(us_hash).to eq(
      'first_name' => 'John',
      'middle_name' => 'Paul',
      'last_name' => 'Doe',
      'trading_name' => 'John Doe Masks',
      'registered_address' => { 'address_line1' => '123 Main Street', 'city' => 'San Francisco', 'state' => 'CA',
                                'zip' => '94105', 'country' => 'US' },
      'date_of_birth' => { 'day' => 5, 'month' => 5, 'year' => 1990 },
      'identification' => { 'national_id_number' => '123456789' },
      'financial_details' => { 'annual_processing_volume' => 120_000, 'average_transaction_value' => 500,
                               'highest_transaction_value' => 2_500, 'currency' => 'USD' }
    )
    expect(serialize(eea)).to eq('first_name' => 'Jean', 'last_name' => 'Dupont',
                                 'place_of_birth' => { 'country' => 'FR' })
    expect(us_hash.keys).not_to include('legal_name', 'national_tax_id')
  end

  it 'serializes Identification to the national_id_number only' do
    identification = CheckoutSdk::Accounts::Identification.new
    identification.national_id_number = '123456789'

    expect(serialize(identification)).to eq('national_id_number' => '123456789')
  end
end
