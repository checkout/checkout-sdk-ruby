RSpec.describe CheckoutSdk::Accounts do

  describe 'when sub entity operations' do
    before(:all) do
      @entity = create_entity
    end
    describe '.create_entity' do
      context 'when creating a entity with valid data' do
        it 'returns a new entity' do
          expect(@entity).not_to be nil
          expect(@entity.id).not_to be nil
          expect(@entity.metadata.status_code).to eq 201
        end
      end
    end

    describe '.get_entity' do
      context 'when fetching a valid entity' do
        it 'returns entity data' do
          response = oauth_sdk.accounts.get_entity @entity.id

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

          response = oauth_sdk.accounts.update_entity(@entity.id, request)

          expect(response).not_to be nil
          expect(response.id).to eq(@entity.id)
          expect(response.metadata.status_code).to eq 200

          verify_update = oauth_sdk.accounts.get_entity @entity.id
          expect(verify_update).not_to be nil
          expect(verify_update.contact_details.phone.number).to eq(request.contact_details.phone.number)
          expect(verify_update.contact_details.email_addresses.primary).to eq(request.contact_details.email_addresses.primary)
          expect(verify_update.profile.urls).to eq(request.profile.urls)
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

        response = oauth_sdk.accounts.upload_file(request)

        expect(response).not_to be nil
        expect(response.id).not_to be nil
      end
    end
  end

  describe '.update_payout_schedule' do
    context 'when update a weekly payout' do
      it 'fail because company_business_registration_number_invalid' do
        frequency = CheckoutSdk::Accounts::ScheduleFrequencyWeekly.new
        frequency.by_day = ['monday']

        request = CheckoutSdk::Accounts::UpdateSchedule.new
        request.enabled = true
        request.threshold = 1000
        request.recurrence = frequency

        expect { payout_schedules_checkout_api.accounts.update_payout_schedule('ent_sdioy6bajpzxyl3utftdp7legq', CheckoutSdk::Common::Currency::USD, request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.error_details[:error_codes].first).to eq 'company_business_registration_number_invalid' }
      end
    end
  end

end

def create_entity
  request = build_entity
  oauth_sdk.accounts.create_entity request
end

def build_entity
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
  request.reference = SecureRandom.uuid
  request.contact_details = contact_details
  request.profile = profile
  request.individual = individual
  request
end

def payout_schedules_checkout_api
  CheckoutSdk.builder
             .oauth
             .with_client_credentials(
               ENV['CHECKOUT_DEFAULT_OAUTH_PAYOUT_SCHEDULE_CLIENT_ID'],
               ENV['CHECKOUT_DEFAULT_OAUTH_PAYOUT_SCHEDULE_CLIENT_SECRET'])
             .with_scopes([CheckoutSdk::OAuthScopes::MARKETPLACE])
             .with_environment(CheckoutSdk::Environment.sandbox)
             .build
end
