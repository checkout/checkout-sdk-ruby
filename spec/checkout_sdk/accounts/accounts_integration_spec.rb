RSpec.describe CheckoutSdk::Accounts do

  before(:all) do
    @accounts_sdk = accounts_checkout_api
    @payout_schedules_sdk = payout_schedules_checkout_api
    @files_sdk = files_checkout_api
  end

  describe 'when sub entity operations' do
    before(:all) do
      @entity = create_entity @accounts_sdk
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
        accounts_checkout_api.accounts.create_entity(build_entity(random_uuid), '2.0')
        expect { accounts_checkout_api.accounts.create_entity(build_entity(random_uuid), '2.0') }
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
          response = @accounts_sdk.accounts.get_entity(@entity.id, '2.0')

          expect(response).not_to be nil
          expect(response.id).to eq(@entity.id)
          expect(response.reference).to eq(@entity.reference)
        end
      end
    end

    describe '.update' do
      context 'when updating a valid entity' do
        it 'should update successfully' do
          request = build_entity
          request.contact_details.phone.number = '1818151551'
          request.contact_details.email_addresses.primary = generate_random_email
          request.profile.urls = ['https://www.anothersuperheroexample.com']

          response = @accounts_sdk.accounts.update_entity(@entity.id, request, '2.0')

          expect(response).not_to be nil
          expect(response.id).to eq(@entity.id)
          expect(response.http_metadata.status_code).to eq 200

          verify_update = @accounts_sdk.accounts.get_entity(@entity.id, '2.0')
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
    # Profile currencies use the platform scope (USD) while processing_details reflects the region (GBP).
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
  end

  describe 'when entity payment instrument operations' do
    before(:all) do
      @entity = create_entity @accounts_sdk
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

    describe '.update_payment_instrument', skip: 'returns 428 status when updating' do
      subject(:payment_instrument) {
        @accounts_sdk.accounts.add_payment_instrument @entity.id, build_payment_instrument(@file)
      }
      context 'when updating existing payment instrument for valid entity' do
        it 'returns http 200' do
          request = CheckoutSdk::Accounts::UpdatePaymentInstrumentRequest.new
          request.label = 'new label'
          request.default = true

          response = @accounts_sdk.accounts.update_payment_instrument @entity.id,
                                                                      payment_instrument.id,
                                                                      request
          assert_response response, %w[id]
        end

        it 'reflects new values for updated fields' do
          response = @accounts_sdk.accounts.retrieve_payment_instrument_details @entity.id,
                                                                                payment_instrument.id

          assert_response response, %w[id
                                       label
                                       default]
          expect(response.label).to eq 'new label'
          expect(response.default).to be true
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

def create_entity(sdk)
  request = build_entity(SecureRandom.uuid)
  # v2.0 payload (top-level individual) — pin to 2.0 (SDK now defaults to 3.0)
  sdk.accounts.create_entity(request, '2.0')
end

def build_entity(reference = nil)
  phone = CheckoutSdk::Accounts::Phone.new
  phone.number = '2345678910'

  email_addresses = CheckoutSdk::Accounts::EntityEmailAddresses.new
  email_addresses.primary = generate_random_email

  contact_details = CheckoutSdk::Accounts::ContactDetails.new
  contact_details.phone = phone
  contact_details.email_addresses = email_addresses

  profile = CheckoutSdk::Accounts::Profile.new
  profile.urls = ['https://www.superheroexample.com']
  profile.mccs = ['0742']

  birth = CheckoutSdk::Accounts::DateOfBirth.new
  birth.day = 5
  birth.month = 5
  birth.year = 1996

  identification = CheckoutSdk::Accounts::Identification.new
  identification.national_id_number = 'AB123456C'

  individual = CheckoutSdk::Accounts::Individual.new
  individual.first_name = Helpers::DataFactory::FIRST_NAME
  individual.last_name = Helpers::DataFactory::LAST_NAME
  individual.trading_name = "Batman's Super Hero Masks"
  individual.registered_address = address
  individual.national_tax_id = 'TAX123456'
  individual.date_of_birth = birth
  individual.identification = identification

  request = CheckoutSdk::Accounts::OnboardEntity.new
  request.reference = reference || SecureRandom.uuid
  request.contact_details = contact_details
  request.profile = profile
  request.individual = individual
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

  # Profile currencies are validated against the platform scope (USD); processing currency is regional (GBP).
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
  processing_details.currency = CheckoutSdk::Common::Currency::GBP
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

  instrument_details = CheckoutSdk::Accounts::InstrumentDetailsFasterPayments.new
  instrument_details.account_number = '12334454'
  instrument_details.bank_code = '050389'

  request = CheckoutSdk::Accounts::PaymentInstrumentRequest.new
  request.label = 'Barclays'
  request.type = CheckoutSdk::Common::InstrumentType::BANK_ACCOUNT
  request.currency = CheckoutSdk::Common::Currency::GBP
  request.country = CheckoutSdk::Common::Country::GB
  request.default = false
  request.document = document
  request.instrument_details = instrument_details
  request
end

def upload_file_accounts(sdk)
  request = CheckoutSdk::Accounts::FileRequest.new
  request.file = './spec/resources/checkout.jpeg'
  request.purpose = 'bank_verification'

  sdk.accounts.upload_file(request)
end

def payout_schedules_checkout_api
  CheckoutSdk.builder
             .oauth
             .with_client_credentials(
               ENV.fetch('CHECKOUT_DEFAULT_OAUTH_CLIENT_ID', nil),
               ENV.fetch('CHECKOUT_DEFAULT_OAUTH_CLIENT_SECRET', nil)
             )
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
