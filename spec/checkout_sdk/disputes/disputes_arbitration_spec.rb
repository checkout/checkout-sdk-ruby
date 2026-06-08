RSpec.describe CheckoutSdk::Disputes do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Disputes::DisputesClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#submit_arbitration' do
    it 'POSTs disputes/{id}/evidence/arbitration' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('disputes/dsp_1/evidence/arbitration', 'secret_key', nil).and_return('r')
      expect(client.submit_arbitration('dsp_1')).to eq('r')
    end
  end

  describe '#get_submitted_arbitration_evidence' do
    it 'GETs disputes/{id}/evidence/arbitration/submitted' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('disputes/dsp_1/evidence/arbitration/submitted', 'secret_key').and_return('r')
      expect(client.get_submitted_arbitration_evidence('dsp_1')).to eq('r')
    end
  end
end
