require 'net/http'

RSpec.describe CheckoutSdk::Accounts do

  before(:all) do
    @accounts_sdk = accounts_checkout_api
    @payout_schedules_sdk = payout_schedules_checkout_api
    @files_sdk = files_checkout_api
  end

  describe 'when sub entity operations' do
    # A schema 3.0 GB Sole Trader Full entity (see build_sole_trader_v3). It replaces the schema 2.0 sole
    # trader (a top-level individual), which the sandbox answers with HTTP 500 even for a body that
    # validates against the spec.
    before(:all) do
      @identity_file = upload_file_accounts(@accounts_sdk, CheckoutSdk::Accounts::FilePurpose::IDENTITY_VERIFICATION)
      @bank_file = upload_file_accounts @accounts_sdk
      @entity = create_entity @accounts_sdk, @identity_file, @bank_file
    end
    describe '.create_entity' do
      context 'when creating a entity with valid data' do
        it 'returns a new entity' do
          expect(@entity).not_to be nil
          expect(@entity.id).not_to be nil
          expect(@entity.http_metadata.status_code).to eq 201
        end
      end
    end

    context 'when sub-entity onboarding request conflicted with an existing sub-entity' do
      it 'raises an error' do
        random_uuid = SecureRandom.uuid
        request = build_sole_trader_v3(random_uuid, @identity_file, @bank_file)
        accounts_checkout_api.accounts.create_entity(request, '3.0')
        expect { accounts_checkout_api.accounts.create_entity(request, '3.0') }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.http_metadata.status_code).to eq 409
            # The conflict body's `id` is not asserted: under an explicit schema_version Accept header
            # the Accounts sandbox returns an empty error body (JSON.parse would fail).
          }
      end
    end

    describe '.get_entity' do
      context 'when fetching a valid entity' do
        it 'returns entity data' do
          response = @accounts_sdk.accounts.get_entity(@entity.id, '3.0')

          expect(response).not_to be nil
          expect(response.id).to eq(@entity.id)
          expect(response.reference).to eq(@entity.reference)
        end
      end
    end

    describe '.update' do
      context 'when updating a valid entity' do
        it 'should update successfully' do
          # The reference is set at creation and not sent again on update.
          request = build_sole_trader_v3(nil, @identity_file, @bank_file)
          request.contact_details.phone.number = '1818151551'
          request.contact_details.email_addresses.primary = generate_random_email
          request.profile.urls = ['https://www.anothersuperheroexample.com']

          response = @accounts_sdk.accounts.update_entity(@entity.id, request, '3.0')

          expect(response).not_to be nil
          expect(response.id).to eq(@entity.id)
          expect(response.http_metadata.status_code).to eq 200

          verify_update = @accounts_sdk.accounts.get_entity(@entity.id, '3.0')
          expect(verify_update).not_to be nil
          expect(verify_update.contact_details.phone.number).to eq(request.contact_details.phone.number)
          expect(verify_update.contact_details.email_addresses.primary).to eq(request.contact_details.email_addresses.primary)
          expect(verify_update.profile.urls).to eq(request.profile.urls)
        end
      end
    end
  end

  describe 'when sub entity operations (Accounts API schema_version 3.0)' do
    # v3.0 onboards a sub-entity as a company whose single representative carries a nested individual
    # + roles. Uses the accounts-scoped OAuth client (provisioned for v3.0) and the SDK default (3.0).
    # Every currency on the request has to sit inside the platform's currency scope, which is USD
    # only. See build_onboard_entity_v3 for why processing_details cannot be regional.
    it 'creates and retrieves a v3.0 company sub-entity' do
      request = build_entity_v3(SecureRandom.uuid)

      created = @accounts_sdk.accounts.create_entity(request)
      expect(created).not_to be nil
      expect(created.id).not_to be nil
      expect(created.http_metadata.status_code).to eq 201

      fetched = @accounts_sdk.accounts.get_entity(created.id)
      expect(fetched).not_to be nil
      expect(fetched.id).to eq(created.id)
    end

    # The representative's documents on schema 3.0. The sandbox platform resolves to a company variant
    # (GB/US scope, USD only), where identity_verification and certified_authorised_signatory are the
    # representative documents the API accepts; the EEA Sole Trader keys are covered by
    # accounts_v3_serialization_spec, since this platform rejects them.
    it 'creates a v3.0 sub-entity with representative documents and reads them back' do
      identity_file = upload_file_accounts(@accounts_sdk, CheckoutSdk::Accounts::FilePurpose::IDENTITY_VERIFICATION)
      signatory_file = upload_file_accounts(@accounts_sdk,
                                            CheckoutSdk::Accounts::FilePurpose::CERTIFIED_AUTHORISED_SIGNATORY)

      identity = CheckoutSdk::Accounts::Document.new
      identity.type = CheckoutSdk::Accounts::DocumentType::PASSPORT
      identity.front = identity_file.id
      signatory = CheckoutSdk::Accounts::CertifiedAuthorisedSignatory.new
      signatory.type = CheckoutSdk::Accounts::CertifiedAuthorisedSignatoryType::POWER_OF_ATTORNEY
      signatory.front = signatory_file.id
      documents = CheckoutSdk::Accounts::RepresentativeDocuments.new
      documents.identity_verification = identity
      documents.certified_authorised_signatory = signatory
      request = build_entity_v3(SecureRandom.uuid)
      request.company.representatives[0].documents = documents

      created = @accounts_sdk.accounts.create_entity(request)
      expect(created.id).not_to be nil

      # The documents are linked on the representative, not dropped: the API echoes them back.
      linked = @accounts_sdk.accounts.get_entity(created.id).company.representatives[0].documents
      expect(linked.identity_verification.type).to eq('passport')
      expect(linked.identity_verification.front).to eq(identity_file.id)
      expect(linked.certified_authorised_signatory.type).to eq('power_of_attorney')
      expect(linked.certified_authorised_signatory.front).to eq(signatory_file.id)
    end

    # POST /entities/{entityId}/files takes only the purpose as JSON and answers with an upload link;
    # the file bytes go to that link in a separate PUT. A v3.0 entity, since the sandbox rejects v2.0 here.
    it 'creates a sub-entity file upload, sends the bytes to the upload link and retrieves the file' do
      entity = @accounts_sdk.accounts.create_entity(build_entity_v3(SecureRandom.uuid))
      request = CheckoutSdk::Accounts::EntityFilesRequest.new
      request.purpose = CheckoutSdk::Accounts::FilePurpose::IDENTITY_VERIFICATION

      upload = @accounts_sdk.accounts.upload_entity_file(entity.id, request)
      expect(upload.id).to match(/^file_[a-z2-7]{26}$/)
      expect(upload._links.upload.href).not_to be_nil

      upload_uri = URI(upload._links.upload.href)
      put_request = Net::HTTP::Put.new(upload_uri)
      put_request['Content-Type'] = 'image/jpeg'
      put_request.body = File.binread('./spec/resources/checkout.jpeg')
      put_response = Net::HTTP.start(upload_uri.host, upload_uri.port, use_ssl: upload_uri.scheme == 'https') do |http|
        http.request(put_request)
      end
      expect(put_response.code.to_i).to be_between(200, 299)

      retrieved = @accounts_sdk.accounts.get_entity_file(entity.id, upload.id)
      expect(retrieved.id).to eq(upload.id)
      expect(retrieved.purpose).to eq(CheckoutSdk::Accounts::FilePurpose::IDENTITY_VERIFICATION)
    end

    # The update only succeeds when the ETag reaches the API as the If-Match HTTP header: without it the
    # API answers 428, and with a stale ETag 412. A v3.0 entity, since the sandbox rejects v2.0 here.
    it 'updates a payment instrument with its ETag' do
      entity = @accounts_sdk.accounts.create_entity(build_entity_v3(SecureRandom.uuid))
      file = upload_file_accounts @accounts_sdk

      instrument_id = @accounts_sdk.accounts.add_payment_instrument(entity.id, build_payment_instrument(file)).id

      details = @accounts_sdk.accounts.retrieve_payment_instrument_details(entity.id, instrument_id)
      request = CheckoutSdk::Accounts::UpdatePaymentInstrumentRequest.new
      request.label = 'Renamed account'
      request.headers = CheckoutSdk::Common::Headers.new
      request.headers.if_match = details.http_metadata.headers['etag']

      response = @accounts_sdk.accounts.update_payment_instrument(entity.id, instrument_id, request)
      expect(response.id).to eq(instrument_id)
      updated = @accounts_sdk.accounts.retrieve_payment_instrument_details(entity.id, instrument_id)
      expect(updated.label).to eq('Renamed account')
    end
  end

  describe 'when entity payment instrument operations' do
    # A schema 3.0 company entity: payment instruments need company data (a sole trader is answered
    # with entity_business_registration_number_required and similar).
    before(:all) do
      @entity = @accounts_sdk.accounts.create_entity(build_entity_v3(SecureRandom.uuid))
      @file = upload_file_accounts @accounts_sdk
    end

    describe '.add_payment_instrument' do
      context 'when adding payment instrument to existing entity' do
        it 'creates instrument for entity successfully' do
          request = build_payment_instrument @file

          response = @accounts_sdk.accounts.add_payment_instrument @entity.id, request

          assert_response response, %w[id]
        end
      end
    end

    describe '.retrieve_payment_instrument_details' do
      context 'when fetching existing payment instrument for valid entity' do
        subject(:payment_instrument) {
          @accounts_sdk.accounts.add_payment_instrument @entity.id, build_payment_instrument(@file)
        }
        it 'retrieves payment instrument details' do
          response = @accounts_sdk.accounts.retrieve_payment_instrument_details @entity.id, payment_instrument.id

          assert_response response, %w[id
                                       status
                                       label
                                       type
                                       currency
                                       country
                                       document]
        end
      end
    end

    describe '.query_payment_instruments' do
      context 'when querying for valid entity' do
        it 'retrieves entity payment instruments' do
          response = @accounts_sdk.accounts.query_payment_instruments @entity.id

          assert_response response, %w[data]
        end
      end
    end

    describe '.update_payment_instrument' do
      context 'when updating existing payment instrument for valid entity' do
        # The API reads the ETag only from the If-Match header: without it the update gets 428.
        it 'updates the instrument and reflects the new values' do
          instrument_id = @accounts_sdk.accounts.add_payment_instrument(@entity.id, build_payment_instrument(@file)).id
          details = @accounts_sdk.accounts.retrieve_payment_instrument_details @entity.id, instrument_id

          request = CheckoutSdk::Accounts::UpdatePaymentInstrumentRequest.new
          request.label = 'new label'
          request.default = true
          request.headers = CheckoutSdk::Common::Headers.new
          request.headers.if_match = details.http_metadata.headers['etag']

          response = @accounts_sdk.accounts.update_payment_instrument @entity.id, instrument_id, request
          assert_response response, %w[id]

          updated = @accounts_sdk.accounts.retrieve_payment_instrument_details @entity.id, instrument_id
          assert_response updated, %w[id
                                      label
                                      default]
          expect(updated.label).to eq 'new label'
          expect(updated.default).to be true
        end
      end
    end
  end


  describe '.upload_file' do
    context 'when uploading a file' do
      it 'returns http 200' do
        request = CheckoutSdk::Accounts::FileRequest.new
        request.file = './spec/resources/checkout.jpeg'
        request.purpose = 'dispute_evidence'

        response = @files_sdk.accounts.upload_file(request)

        expect(response).not_to be nil
        expect(response.id).not_to be nil
      end
    end
  end

  skip 'Skipping because payouts client_id does not have access to accounts scope' do
    describe '.update_payout_schedule' do
      context 'when update a weekly payout' do
        it 'fail because company_business_registration_number_invalid' do
          frequency = CheckoutSdk::Accounts::ScheduleFrequencyWeekly.new
          frequency.by_day = ['monday']

          request = CheckoutSdk::Accounts::UpdateSchedule.new
          request.enabled = true
          request.threshold = 1000
          request.recurrence = frequency

          expect { @payout_schedules_sdk.accounts.update_payout_schedule('ent_sdioy6bajpzxyl3utftdp7legq', CheckoutSdk::Common::Currency::USD, request) }
            .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.error_details[:error_codes].first).to eq 'company_business_registration_number_invalid' }
        end
      end
    end
  end
end

private

def create_entity(sdk, identity_file, bank_file)
  sdk.accounts.create_entity(build_sole_trader_v3(SecureRandom.uuid, identity_file, bank_file), '3.0')
end

# A schema 3.0 GB Sole Trader Full request (GBSoleTraderFull3-0): a company of business type
# individual_or_sole_proprietorship with exactly one ubo representative, the representative's identity
# document and the top-level bank statement. The processing currency is USD, the only currency in the
# sandbox platform's currency scope (see build_entity_v3); the addresses and settlement country stay GB.
def build_sole_trader_v3(reference, identity_file, bank_file)
  phone = CheckoutSdk::Accounts::Phone.new
  phone.country_code = 'GB'
  phone.number = '2072343000'

  email_addresses = CheckoutSdk::Accounts::EntityEmailAddresses.new
  email_addresses.primary = generate_random_email

  contact_details = CheckoutSdk::Accounts::ContactDetails.new
  contact_details.phone = phone
  contact_details.email_addresses = email_addresses

  profile = CheckoutSdk::Accounts::Profile.new
  profile.urls = ['https://www.superheroexample.com']
  profile.mccs = ['0742']
  profile.default_holding_currency = CheckoutSdk::Common::Currency::USD
  profile.holding_currencies = [CheckoutSdk::Common::Currency::USD]

  dob = CheckoutSdk::Accounts::DateOfBirth.new
  dob.day = 5
  dob.month = 6
  dob.year = 1995

  pob = CheckoutSdk::Accounts::PlaceOfBirth.new
  pob.country = CheckoutSdk::Common::Country::GB

  individual = CheckoutSdk::Accounts::RepresentativeIndividual.new
  individual.first_name = Helpers::DataFactory::FIRST_NAME
  individual.last_name = Helpers::DataFactory::LAST_NAME
  individual.email_address = generate_random_email
  individual.date_of_birth = dob
  individual.place_of_birth = pob
  individual.address = address

  identity = CheckoutSdk::Accounts::Document.new
  identity.type = CheckoutSdk::Accounts::DocumentType::PASSPORT
  identity.front = identity_file.id
  representative_documents = CheckoutSdk::Accounts::RepresentativeDocuments.new
  representative_documents.identity_verification = identity

  representative = CheckoutSdk::Accounts::Representative.new
  representative.individual = individual
  representative.roles = [CheckoutSdk::Accounts::EntityRoles::UBO]
  representative.documents = representative_documents

  doi = CheckoutSdk::Accounts::DateOfIncorporation.new
  doi.month = 6
  doi.year = 2015

  company = CheckoutSdk::Accounts::Company.new
  company.trading_name = "Batman's Super Hero Masks"
  company.business_type = CheckoutSdk::Accounts::BusinessType::INDIVIDUAL_OR_SOLE_PROPRIETORSHIP
  company.date_of_incorporation = doi
  company.principal_address = address
  company.representatives = [representative]

  processing_details = CheckoutSdk::Accounts::ProcessingDetails.new
  processing_details.settlement_country = 'GB'
  processing_details.target_countries = ['GB']
  processing_details.annual_processing_volume = 1_000_000
  processing_details.average_transaction_value = 5_000
  processing_details.highest_transaction_value = 25_000
  processing_details.currency = CheckoutSdk::Common::Currency::USD

  bank_statement = CheckoutSdk::Accounts::BankVerification.new
  bank_statement.type = CheckoutSdk::Accounts::BankVerificationType::BANK_STATEMENT
  bank_statement.front = bank_file.id
  documents = CheckoutSdk::Accounts::OnboardSubEntityDocuments.new
  documents.bank_verification = bank_statement

  request = CheckoutSdk::Accounts::OnboardEntity.new
  request.reference = reference
  request.contact_details = contact_details
  request.profile = profile
  request.company = company
  request.processing_details = processing_details
  request.documents = documents
  request
end

def build_entity_v3(reference = nil)
  phone = CheckoutSdk::Accounts::Phone.new
  phone.country_code = 'GB'
  phone.number = '2345678910'

  email_addresses = CheckoutSdk::Accounts::EntityEmailAddresses.new
  email_addresses.primary = generate_random_email

  contact_details = CheckoutSdk::Accounts::ContactDetails.new
  contact_details.phone = phone
  contact_details.email_addresses = email_addresses

  # Every currency here has to sit inside the platform's currency scope, which is USD only. The
  # processing currency was previously GBP, on the theory that the profile reflects the platform
  # while processing details reflect the sub-entity region. The API rejects that with
  # processing_details_currency_invalid_for_currency_scope, and widening the profile to GBP is also
  # rejected because the scope itself does not permit GBP. The GB settlement_country and addresses
  # are unaffected and still accepted.
  profile = CheckoutSdk::Accounts::Profile.new
  profile.urls = ['https://www.superheroexample.com']
  profile.mccs = ['0742']
  profile.default_holding_currency = CheckoutSdk::Common::Currency::USD
  profile.holding_currencies = [CheckoutSdk::Common::Currency::USD]

  dob = CheckoutSdk::Accounts::DateOfBirth.new
  dob.day = 5
  dob.month = 6
  dob.year = 1995

  pob = CheckoutSdk::Accounts::PlaceOfBirth.new
  pob.country = CheckoutSdk::Common::Country::GB

  individual = CheckoutSdk::Accounts::RepresentativeIndividual.new
  individual.first_name = 'John'
  individual.last_name = 'Doe'
  individual.date_of_birth = dob
  individual.place_of_birth = pob
  individual.address = address

  representative = CheckoutSdk::Accounts::Representative.new
  representative.individual = individual
  representative.roles = [
    CheckoutSdk::Accounts::EntityRoles::UBO,
    CheckoutSdk::Accounts::EntityRoles::AUTHORISED_SIGNATORY,
    CheckoutSdk::Accounts::EntityRoles::DIRECTOR,
    CheckoutSdk::Accounts::EntityRoles::CONTROL_PERSON
  ]

  doi = CheckoutSdk::Accounts::DateOfIncorporation.new
  doi.day = 1
  doi.month = 6
  doi.year = 2010

  company = CheckoutSdk::Accounts::Company.new
  company.business_registration_number = '01234567'
  company.business_type = CheckoutSdk::Accounts::BusinessType::LIMITED_COMPANY
  company.legal_name = 'Super Hero Masks Inc.'
  company.trading_name = 'Super Hero Masks'
  company.date_of_incorporation = doi
  company.principal_address = address
  company.registered_address = address
  company.representatives = [representative]

  ach = CheckoutSdk::Accounts::ProcessingDetailsAch.new
  ach.annual_ach_volume = 1_000_000
  ach.average_ach_transaction_size = 5_000
  ach.estimated_monthly_credit_volume = 100_000
  ach.average_credit_amount = 5_000

  payments = CheckoutSdk::Accounts::ProcessingDetailsPayments.new
  payments.ach = ach

  processing_details = CheckoutSdk::Accounts::ProcessingDetails.new
  processing_details.annual_processing_volume = 1_000_000
  processing_details.average_transaction_value = 5_000
  processing_details.average_order_fulfillment_time = 3
  processing_details.highest_transaction_value = 25_000
  processing_details.currency = CheckoutSdk::Common::Currency::USD
  processing_details.settlement_country = 'GB'
  processing_details.target_countries = ['GB']
  processing_details.payments = payments

  request = CheckoutSdk::Accounts::OnboardEntity.new
  request.reference = reference || SecureRandom.uuid
  request.contact_details = contact_details
  request.profile = profile
  request.company = company
  request.processing_details = processing_details
  request
end

def build_payment_instrument(file)
  document = CheckoutSdk::Accounts::InstrumentDocument.new
  document.type = 'bank_statement'
  document.file_id = file.id

  # A USD ACH account: USD is the only currency in the sandbox platform's scope. The sandbox rejects
  # account_type checking (instrument_details_account_type_invalid), although the spec lists it.
  instrument_details = CheckoutSdk::Accounts::InstrumentDetailsAch.new
  instrument_details.account_number = '123456789'
  instrument_details.routing_number = '026009593'
  instrument_details.account_type = 'savings'

  request = CheckoutSdk::Accounts::PaymentInstrumentRequest.new
  request.label = 'Main account'
  request.type = CheckoutSdk::Common::InstrumentType::BANK_ACCOUNT
  request.currency = CheckoutSdk::Common::Currency::USD
  request.country = CheckoutSdk::Common::Country::US
  request.default = false
  request.document = document
  request.instrument_details = instrument_details
  request
end

def upload_file_accounts(sdk, purpose = CheckoutSdk::Accounts::FilePurpose::BANK_VERIFICATION)
  request = CheckoutSdk::Accounts::FileRequest.new
  request.file = './spec/resources/checkout.jpeg'
  request.purpose = purpose

  sdk.accounts.upload_file(request)
end

def payout_schedules_checkout_api
  CheckoutSdk.builder
             .oauth
             .with_client_credentials(
               ENV.fetch('CHECKOUT_DEFAULT_OAUTH_PAYOUT_SCHEDULE_CLIENT_ID', nil),
               ENV.fetch('CHECKOUT_DEFAULT_OAUTH_PAYOUT_SCHEDULE_CLIENT_SECRET', nil)
             )
             # This client is provisioned for marketplace and not for accounts -- see the skip at
             # the top of .update_payout_schedule, and note that the token endpoint answers a
             # request for accounts here with {"error":"invalid_scope"}. Because this runs in a
             # before(:all) hook, that failure takes down every example in this file, not just the
             # payout ones. Switch to ACCOUNTS once the client is reprovisioned.
             .with_scopes([CheckoutSdk::OAuthScopes::MARKETPLACE])
             .with_environment(CheckoutSdk::Environment.sandbox)
             # The sandbox OAuth clients are not provisioned for the merchant-specific subdomain,
             # so the token request would come back invalid_client. Opting out explicitly until
             # they are.
             .with_legacy_domain
             .build
end

def accounts_checkout_api
  CheckoutSdk.builder
             .oauth
             .with_client_credentials(
               ENV.fetch('CHECKOUT_DEFAULT_OAUTH_ACCOUNTS_CLIENT_ID', nil),
               ENV.fetch('CHECKOUT_DEFAULT_OAUTH_ACCOUNTS_CLIENT_SECRET', nil)
             )
             .with_scopes([CheckoutSdk::OAuthScopes::ACCOUNTS, CheckoutSdk::OAuthScopes::FILES])
             .with_environment(CheckoutSdk::Environment.sandbox)
             # See payout_schedules_checkout_api above for why the legacy domain is used here.
             .with_legacy_domain
             .build
end

def files_checkout_api
  CheckoutSdk.builder
             .oauth
             .with_client_credentials(
               ENV.fetch('CHECKOUT_DEFAULT_OAUTH_ACCOUNTS_CLIENT_ID', nil),
               ENV.fetch('CHECKOUT_DEFAULT_OAUTH_ACCOUNTS_CLIENT_SECRET', nil)
             )
             .with_scopes([CheckoutSdk::OAuthScopes::FILES])
             .with_environment(CheckoutSdk::Environment.sandbox)
             # See payout_schedules_checkout_api above for why the legacy domain is used here.
             .with_legacy_domain
             .build
end
