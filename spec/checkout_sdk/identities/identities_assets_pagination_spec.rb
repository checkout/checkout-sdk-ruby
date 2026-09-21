# frozen_string_literal: true

# Part A (the two new attempt-assets endpoints) and part F M1 (pagination on all four
# list-attempts endpoints) of the 2026-09-02 swagger delta.
RSpec.describe 'Identities attempt assets and pagination' do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  def pagination
    query = CheckoutSdk::Identities::IdvAttemptsQueryFilter.new
    query.skip = 5
    query.limit = 25
    query
  end

  def asset_pagination
    query = CheckoutSdk::Identities::IdvAttemptAssetsQueryFilter.new
    query.skip = 2
    query.limit = 50
    query
  end

  describe 'AddressDocumentVerificationClient' do
    let(:client) do
      CheckoutSdk::Identities::AddressDocumentVerification::AddressDocumentVerificationClient
        .new(api_client_mock, configuration_mock)
    end

    it 'GETs the new attempts/{attempt_id}/assets path' do
      query = asset_pagination
      expect(api_client_mock).to receive(:invoke_get)
        .with('address-document-verifications/adv_x/attempts/adva_x/assets', 'secret_key', query)
        .and_return('response')

      expect(client.get_address_document_verification_attempt_assets('adv_x', 'adva_x', query))
        .to eq('response')
    end

    it 'sends no query when the assets filter is omitted' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('address-document-verifications/adv_x/attempts/adva_x/assets', 'secret_key', nil)
        .and_return('response')

      expect(client.get_address_document_verification_attempt_assets('adv_x', 'adva_x'))
        .to eq('response')
    end

    it 'forwards the pagination filter on the attempts list' do
      query = pagination
      expect(api_client_mock).to receive(:invoke_get)
        .with('address-document-verifications/adv_x/attempts', 'secret_key', query)
        .and_return('response')

      expect(client.get_address_document_verification_attempts('adv_x', query)).to eq('response')
    end
  end

  describe 'IdDocumentVerificationClient' do
    let(:client) do
      CheckoutSdk::Identities::IdDocumentVerification::IdDocumentVerificationClient
        .new(api_client_mock, configuration_mock)
    end

    it 'GETs the new attempts/{attempt_id}/assets path' do
      query = asset_pagination
      expect(api_client_mock).to receive(:invoke_get)
        .with('id-document-verifications/iddv_x/attempts/datp_x/assets', 'secret_key', query)
        .and_return('response')

      expect(client.get_id_document_verification_attempt_assets('iddv_x', 'datp_x', query))
        .to eq('response')
    end

    it 'sends no query when the assets filter is omitted' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('id-document-verifications/iddv_x/attempts/datp_x/assets', 'secret_key', nil)
        .and_return('response')

      expect(client.get_id_document_verification_attempt_assets('iddv_x', 'datp_x'))
        .to eq('response')
    end

    it 'forwards the pagination filter on the attempts list' do
      query = pagination
      expect(api_client_mock).to receive(:invoke_get)
        .with('id-document-verifications/iddv_x/attempts', 'secret_key', query).and_return('response')

      expect(client.get_id_document_verification_attempts('iddv_x', query)).to eq('response')
    end
  end

  describe 'IdentityVerificationClient' do
    let(:client) do
      CheckoutSdk::Identities::IdentityVerification::IdentityVerificationClient
        .new(api_client_mock, configuration_mock)
    end

    it 'forwards the pagination filter on the attempts list' do
      query = pagination
      expect(api_client_mock).to receive(:invoke_get)
        .with('identity-verifications/idv_x/attempts', 'secret_key', query).and_return('response')

      expect(client.get_identity_verification_attempts('idv_x', query)).to eq('response')
    end

    it 'accepts the typed assets filter on the pre-existing assets method' do
      query = asset_pagination
      expect(api_client_mock).to receive(:invoke_get)
        .with('identity-verifications/idv_x/attempts/att_x/assets', 'secret_key', query)
        .and_return('response')

      expect(client.get_identity_verification_attempt_assets('idv_x', 'att_x', query))
        .to eq('response')
    end
  end

  describe 'FaceAuthenticationClient' do
    let(:client) do
      CheckoutSdk::Identities::FaceAuthentication::FaceAuthenticationClient
        .new(api_client_mock, configuration_mock)
    end

    it 'forwards the pagination filter on the attempts list' do
      query = pagination
      expect(api_client_mock).to receive(:invoke_get)
        .with('face-authentications/fa_x/attempts', 'secret_key', query).and_return('response')

      expect(client.get_face_authentication_attempts('fa_x', query)).to eq('response')
    end
  end

  describe 'the query filters' do
    it 'serializes skip and limit' do
      expect(CheckoutSdk::JsonSerializer.to_custom_hash(pagination))
        .to eq('skip' => 5, 'limit' => 25)
    end

    it 'keeps an explicit zero skip, unlike the PHP and Go filters' do
      query = CheckoutSdk::Identities::IdvAttemptsQueryFilter.new
      query.skip = 0
      query.limit = 10

      expect(CheckoutSdk::JsonSerializer.to_custom_hash(query)).to eq('skip' => 0, 'limit' => 10)
    end

    it 'omits unset members' do
      query = CheckoutSdk::Identities::IdvAttemptsQueryFilter.new
      query.limit = 25

      expect(CheckoutSdk::JsonSerializer.to_custom_hash(query)).to eq('limit' => 25)
    end

    it 'encodes to a query string through append_params' do
      client = CheckoutSdk::ApiClient.allocate
      expect(client.send(:append_params, 'attempts', pagination)).to eq('attempts?skip=5&limit=25')
    end
  end
end
