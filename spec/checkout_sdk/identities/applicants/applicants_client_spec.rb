RSpec.describe CheckoutSdk::Identities::Applicants do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Identities::Applicants::ApplicantsClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_applicant' do
    it 'POSTs typed DTO to applicants' do
      request = CheckoutSdk::Identities::Applicants::CreateApplicantRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('applicants', 'secret_key', request).and_return('response')
      expect(client.create_applicant(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'reference' => 'ref-1' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('applicants', 'secret_key', hash_request).and_return('response')
      expect(client.create_applicant(hash_request)).to eq('response')
    end
  end

  describe '#get_applicant' do
    it 'GETs applicants/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('applicants/aplt_x', 'secret_key').and_return('response')
      expect(client.get_applicant('aplt_x')).to eq('response')
    end
  end

  describe '#update_applicant' do
    it 'PUTs typed DTO to applicants/{id}' do
      request = CheckoutSdk::Identities::Applicants::UpdateApplicantRequest.new
      expect(api_client_mock).to receive(:invoke_put)
        .with('applicants/aplt_x', 'secret_key', request).and_return('response')
      expect(client.update_applicant('aplt_x', request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'reference' => 'ref-2' }
      expect(api_client_mock).to receive(:invoke_put)
        .with('applicants/aplt_x', 'secret_key', hash_request).and_return('response')
      expect(client.update_applicant('aplt_x', hash_request)).to eq('response')
    end
  end

  describe '#anonymize_applicant' do
    it 'POSTs applicants/{id}/anonymize' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('applicants/aplt_x/anonymize', 'secret_key').and_return('response')
      expect(client.anonymize_applicant('aplt_x')).to eq('response')
    end
  end
end
