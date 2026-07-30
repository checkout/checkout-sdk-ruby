# frozen_string_literal: true

RSpec.describe CheckoutSdk::Accounts do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:files_client_mock) { double('files_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) do
    CheckoutSdk::Accounts::AccountsClient.new(api_client_mock, files_client_mock, configuration_mock)
  end

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe 'Accounts API schema_version negotiation via the Accept header' do
    it 'create_entity sends the default schema_version 3.0' do
      req = CheckoutSdk::Accounts::OnboardEntity.new
      expect(api_client_mock).to receive(:invoke_post) do |path, auth, body, idempotency_key, headers|
        expect(path).to eq('accounts/entities')
        expect(auth).to eq('secret_key')
        expect(body).to eq(req)
        expect(idempotency_key).to be_nil
        expect(headers).to be_a(CheckoutSdk::Common::Headers)
        expect(headers.accept).to eq('application/json;schema_version=3.0')
        'r'
      end
      expect(client.create_entity(req)).to eq('r')
    end

    it 'get_entity sends the default schema_version 3.0' do
      expect(api_client_mock).to receive(:invoke_get) do |path, auth, params, headers|
        expect(path).to eq('accounts/entities/ent_1')
        expect(params).to be_nil
        expect(headers.accept).to eq('application/json;schema_version=3.0')
        'r'
      end
      expect(client.get_entity('ent_1')).to eq('r')
    end

    it 'update_entity sends the default schema_version 3.0' do
      req = CheckoutSdk::Accounts::OnboardEntity.new
      expect(api_client_mock).to receive(:invoke_put) do |path, auth, body, headers|
        expect(path).to eq('accounts/entities/ent_1')
        expect(body).to eq(req)
        expect(headers.accept).to eq('application/json;schema_version=3.0')
        'r'
      end
      expect(client.update_entity('ent_1', req)).to eq('r')
    end

    it 'get_entity_requirements sends the default schema_version 3.0' do
      expect(api_client_mock).to receive(:invoke_get) do |path, _auth, params, headers|
        expect(path).to eq('accounts/entities/ent_1/requirements')
        expect(params).to be_nil
        expect(headers.accept).to eq('application/json;schema_version=3.0')
        'r'
      end
      expect(client.get_entity_requirements('ent_1')).to eq('r')
    end

    it 'honors a schema_version override' do
      expect(api_client_mock).to receive(:invoke_get) do |_path, _auth, _params, headers|
        expect(headers.accept).to eq('application/json;schema_version=2.0')
        'r'
      end
      expect(client.get_entity('ent_1', '2.0')).to eq('r')
    end
  end
end
