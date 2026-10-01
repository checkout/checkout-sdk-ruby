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

  describe 'file uploads, routed through the files client' do
    it 'upload_file submits the file to files' do
      request = CheckoutSdk::Accounts::FileRequest.new
      request.file = './spec/resources/checkout.jpeg'
      request.purpose = CheckoutSdk::Accounts::FilePurpose::PROOF_OF_REGISTRATION
      expect(files_client_mock).to receive(:submit_file).with('files', 'secret_key', request).and_return('r')

      expect(client.upload_file(request)).to eq('r')
    end

    it 'upload_entity_file submits the file to entities/{entity_id}/files' do
      request = CheckoutSdk::Accounts::EntityFilesRequest.new
      request.purpose = CheckoutSdk::Accounts::FilePurpose::PROOF_OF_RESIDENTIAL_ADDRESS
      expect(files_client_mock).to receive(:submit_file)
        .with('entities/ent_1/files', 'secret_key', request).and_return('r')

      expect(client.upload_entity_file('ent_1', request)).to eq('r')
    end

    it 'get_entity_file reads entities/{entity_id}/files/{file_id}' do
      expect(files_client_mock).to receive(:invoke_get)
        .with('entities/ent_1/files/file_1', 'secret_key').and_return('r')

      expect(client.get_entity_file('ent_1', 'file_1')).to eq('r')
    end
  end
end
