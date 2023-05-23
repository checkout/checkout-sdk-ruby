# frozen_string_literal: true

RSpec.describe CheckoutSdk::Issuing do
  include IssuingHelper

  skip 'Avoid creating cards all the time' do
    before(:all) do
      @cardholder = create_cardholder
      @card = create_card @cardholder.id
    end

    describe '.create_card' do
      context 'when creating a card with valid data' do
        it { is_valid_card @card }
      end
    end

    describe '.get_card_details' do
      context 'when retrieving existing card details' do
        it { is_valid_card_details get_issuing_api.issuing.get_card_details @card.id }
      end
    end

    describe '.enroll_three_ds' do
      context 'when enrolling card into 3DS with valid data' do
        it { is_accepted get_issuing_api.issuing.enroll_three_ds @card.id, get_enrollment_request }
      end
    end

    describe '.update_three_ds_enrollment' do
      context 'when updating 3DS enrollment of existing card with valid data' do
        it { is_accepted get_issuing_api.issuing.update_three_ds_enrollment @card.id, get_enrollment_request }
      end
    end

    describe '.get_card_three_ds_details' do
      context 'when retrieving 3DS enrollment details from valid card' do
        it { retrieves_valid_3ds_details get_issuing_api.issuing.get_card_three_ds_details @card.id }
      end
    end

    describe '.activate_card' do
      context 'when activating a valid card' do
        it { is_successful get_issuing_api.issuing.activate_card @card.id }
        it { is_status 'active', get_issuing_api.issuing.get_card_details(@card.id) }
      end
    end

    describe '.get_card_credentials' do
      context 'when retreiving card credentials for existing card' do
        it { is_valid_card_credentials get_issuing_api.issuing.get_card_credentials @card.id, get_credentials_query }
      end
    end

    describe '.revoke_card' do
      before(:all) do
        @card = create_card @cardholder.id, true
      end
      context 'when revoking a valid card' do
        it { is_successful get_issuing_api.issuing.revoke_card @card.id, { 'reason' => 'reported_stolen' } }
        it { is_status 'revoked', get_issuing_api.issuing.get_card_details(@card.id) }
      end
    end

    describe '.suspend_card' do
      before(:all) do
        @card = create_card @cardholder.id, true
      end
      context 'when suspending a valid card' do
        it { is_successful get_issuing_api.issuing.suspend_card @card.id, { 'reason' => 'suspected_stolen' } }
        it { is_status 'suspended', get_issuing_api.issuing.get_card_details(@card.id) }
      end
    end
  end
end

def is_valid_card(card)
  assert_response card, %w[id
                           display_name
                           last_four
                           expiry_month
                           expiry_year
                           billing_currency
                           issuing_country
                           reference]

  expect(card.display_name).to eq 'JOHN KENNEDY'
  expect(card.reference).to eq 'X-123456-N11'
end

def is_valid_card_details(card)
  assert_response card, %w[id
                           cardholder_id
                           card_product_id
                           display_name
                           last_four
                           expiry_month
                           expiry_year
                           billing_currency
                           issuing_country
                           reference
                           status
                           type]

  expect(card.id).to eq @card.id
  expect(card.cardholder_id).to eq @cardholder.id
  expect(card.display_name).to eq 'JOHN KENNEDY'
  expect(card.reference).to eq 'X-123456-N11'
end

def is_accepted(response)
  assert_response response, %w[http_metadata]

  expect(response.http_metadata.status_code).to eq 202
end

def is_successful(response)
  assert_response response, %w[http_metadata]

  expect(response.http_metadata.status_code).to eq 200
end

def retrieves_valid_3ds_details(response)
  assert_response response, %w[locale
                               phone_number]

  expect(response.locale).to eq 'en-US'
  expect(response.phone_number.country_code).to eq '+1'
  expect(response.phone_number.number).to eq '415 555 2671'
end

def is_status(status, response)
  assert_response response, %w[id
                               cardholder_id
                               card_product_id
                               display_name
                               last_four
                               expiry_month
                               expiry_year
                               billing_currency
                               issuing_country
                               reference
                               status
                               type]

  expect(response.status).to eq status
end

def is_valid_card_credentials(response)
  assert_response response, %w[number
                               cvc2]
end

private

# @return [Hash]
def get_enrollment_request
  {
    'password' => 'Xtui43FvfiZ',
    'locale' => 'en-US',
    'phone_number' => {
      'country_code' => '+1',
      'number' => '415 555 2671'
    }
  }
end

# @return [Hash]
def get_credentials_query
  { 'credentials' => 'number, cvc2' }
end
