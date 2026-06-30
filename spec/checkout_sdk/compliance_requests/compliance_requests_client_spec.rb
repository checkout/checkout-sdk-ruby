RSpec.describe CheckoutSdk::ComplianceRequests do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::ComplianceRequests::ComplianceRequestsClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#get_compliance_request' do
    it 'GETs compliance-requests/{payment_id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('compliance-requests/pay_123', 'secret_key')
        .and_return('response')
      expect(client.get_compliance_request('pay_123')).to eq('response')
    end
  end

  describe '#respond_to_compliance_request' do
    it 'POSTs typed DTO to compliance-requests/{payment_id}' do
      request = CheckoutSdk::ComplianceRequests::ComplianceResponseRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('compliance-requests/pay_123', 'secret_key', request)
        .and_return('response')
      expect(client.respond_to_compliance_request('pay_123', request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'comments' => 'note', 'fields' => { 'sender' => [] } }
      expect(api_client_mock).to receive(:invoke_post)
        .with('compliance-requests/pay_123', 'secret_key', hash_request)
        .and_return('response')
      expect(client.respond_to_compliance_request('pay_123', hash_request)).to eq('response')
    end
  end
end
