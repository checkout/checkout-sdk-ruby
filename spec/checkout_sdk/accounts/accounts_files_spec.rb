# frozen_string_literal: true

RSpec.describe CheckoutSdk::Accounts do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:files_client_mock) { double('files_client') }
  let(:configuration_mock) { double('configuration') }
  let(:entity_id) { 'ent_ovpg62ssyywodc4veodhelfrpv' }
  let(:file_id) { 'file_6lbss42ezvoufcb2beo76rvwly' }
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

    it 'upload_entity_file posts the purpose as JSON to entities/{entity_id}/files' do
      request = CheckoutSdk::Accounts::EntityFilesRequest.new
      request.purpose = CheckoutSdk::Accounts::FilePurpose::PROOF_OF_RESIDENTIAL_ADDRESS
      expect(files_client_mock).to receive(:invoke_post)
        .with("entities/#{entity_id}/files", 'secret_key', request).and_return('r')

      expect(client.upload_entity_file(entity_id, request)).to eq('r')
    end

    it 'upload_entity_file accepts a Hash request' do
      request = { purpose: CheckoutSdk::Accounts::FilePurpose::IDENTITY_VERIFICATION }
      expect(files_client_mock).to receive(:invoke_post)
        .with("entities/#{entity_id}/files", 'secret_key', request).and_return('r')

      expect(client.upload_entity_file(entity_id, request)).to eq('r')
    end

    it 'get_entity_file reads entities/{entity_id}/files/{file_id}' do
      expect(files_client_mock).to receive(:invoke_get)
        .with("entities/#{entity_id}/files/#{file_id}", 'secret_key').and_return('r')

      expect(client.get_entity_file(entity_id, file_id)).to eq('r')
    end
  end

  # The SDK has no typed file models: requests go through JsonSerializer and responses come back as
  # OpenStruct. The payloads below are the per-field swagger examples of PlatformsFileUploadResponse and
  # PlatformsFileRetrieveResponse, driven through the real parse path.
  describe 'file request and response shapes' do
    let(:configuration) do
      double(
        'CheckoutConfiguration',
        http_client: Faraday.new,
        multipart_http_client: Faraday.new,
        logger: Logger.new(File::NULL)
      )
    end
    let(:api_client) { CheckoutSdk::ApiClient.new(configuration, 'https://files.sandbox.checkout.com') }

    def parse(body)
      response = double('Response', status: 200, body: body, headers: { 'Content-Type' => 'application/json' })
      allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
        OpenStruct.new(status_code: 200, body: body)
      )
      api_client.send(:parse_response, response)
    end

    it 'serializes EntityFilesRequest to the purpose only' do
      request = CheckoutSdk::Accounts::EntityFilesRequest.new
      request.purpose = CheckoutSdk::Accounts::FilePurpose::IDENTITY_VERIFICATION

      expect(CheckoutSdk::JsonSerializer.to_custom_hash(request)).to eq('purpose' => 'identity_verification')
    end

    it 'parses every field of the PlatformsFileUploadResponse example' do
      upload_href = 'https://s3.eu-west-1.amazonaws.com/mp-files-api-staging-prod/ent_ociwguf5a5fe3ndmpnvpnwsi3e/' \
                    "#{file_id}?AWSAccessKeyId=ASIX4BFJOBCQFLAMPKU3&Expires=1661355993&x-amz-security-token=some_token"
      body = {
        'id' => file_id,
        'maximum_size_in_bytes' => 4_194_304,
        'document_types_for_purpose' => %w[image/jpeg image/png image/jpg],
        '_links' => {
          'upload' => { 'href' => upload_href },
          'self' => { 'href' => "https://files.checkout.com/files/#{file_id}" }
        }
      }.to_json

      result = parse(body)

      expect(result.id).to eq(file_id)
      expect(result.maximum_size_in_bytes).to eq(4_194_304)
      expect(result.document_types_for_purpose).to eq(%w[image/jpeg image/png image/jpg])
      expect(result._links.upload.href).to eq(upload_href)
      expect(result._links.self.href).to eq("https://files.checkout.com/files/#{file_id}")
    end

    it 'parses every field of the PlatformsFileRetrieveResponse example' do
      download_href = 'https://s3.eu-west-1.amazonaws.com/mp-files-api-clean-prod/ent_ociwguf5a5fe3ndmpnvpnwsi3e/' \
                      "#{file_id}?X-Amz-Expires=3600&x-amz-security-token=some_token"
      body = {
        'id' => file_id,
        'status' => 'invalid',
        'status_reasons' => ['InvalidMimeType'],
        'size' => 1024,
        'mime_type' => 'application/pdf',
        'uploaded_on' => '2020-12-01T15:01:01.0000000+00:00',
        'purpose' => 'identity_verification',
        '_links' => {
          'download' => { 'href' => download_href },
          'self' => { 'href' => "https://files.checkout.com/files/#{file_id}" }
        }
      }.to_json

      result = parse(body)

      expect(result.id).to eq(file_id)
      expect(result.status).to eq('invalid')
      expect(result.status_reasons).to eq(['InvalidMimeType'])
      expect(result.size).to eq(1024)
      expect(result.mime_type).to eq('application/pdf')
      # Seven fractional digits: the SDK keeps the value as the raw string, it never parses it as a date.
      expect(result.uploaded_on).to eq('2020-12-01T15:01:01.0000000+00:00')
      expect(result.purpose).to eq('identity_verification')
      expect(result._links.download.href).to eq(download_href)
      expect(result._links.self.href).to eq("https://files.checkout.com/files/#{file_id}")
    end
  end
end
