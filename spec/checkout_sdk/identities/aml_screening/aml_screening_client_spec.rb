RSpec.describe CheckoutSdk::Identities::AmlScreening do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Identities::AmlScreening::AmlScreeningClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_aml_verification' do
    it 'POSTs typed DTO to aml-verifications' do
      request = CheckoutSdk::Identities::AmlScreening::AmlVerificationRequest.new
      request.applicant_id = 'aplt_x'
      request.search_parameters = CheckoutSdk::Identities::AmlScreening::AmlSearchParameters.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('aml-verifications', 'secret_key', request).and_return('response')
      expect(client.create_aml_verification(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = {
        'applicant_id' => 'aplt_x',
        'search_parameters' => { 'configuration_identifier' => 'cfg_1' }
      }
      expect(api_client_mock).to receive(:invoke_post)
        .with('aml-verifications', 'secret_key', hash_request).and_return('response')
      expect(client.create_aml_verification(hash_request)).to eq('response')
    end
  end

  describe '#get_aml_verification' do
    it 'GETs aml-verifications/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('aml-verifications/amlv_x', 'secret_key').and_return('response')
      expect(client.get_aml_verification('amlv_x')).to eq('response')
    end
  end
end
