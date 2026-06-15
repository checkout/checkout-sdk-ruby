RSpec.describe CheckoutSdk::Payments do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Payments::GooglePayClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('oauth')
  end

  describe '#enroll_entity' do
    it 'POSTs typed DTO to googlepay/enrollments' do
      req = CheckoutSdk::Payments::GooglePayEnrollmentRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('googlepay/enrollments', 'oauth', req).and_return('r')
      expect(client.enroll_entity(req)).to eq('r')
    end

    it 'also accepts a raw Hash' do
      h = { 'entity_id' => 'ent_1' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('googlepay/enrollments', 'oauth', h).and_return('r')
      expect(client.enroll_entity(h)).to eq('r')
    end
  end

  describe '#register_domain' do
    it 'POSTs typed DTO to googlepay/enrollments/{id}/domain' do
      req = CheckoutSdk::Payments::GooglePayDomainRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('googlepay/enrollments/ent_1/domain', 'oauth', req).and_return('r')
      expect(client.register_domain('ent_1', req)).to eq('r')
    end
  end

  describe '#get_registered_domains' do
    it 'GETs googlepay/enrollments/{id}/domains' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('googlepay/enrollments/ent_1/domains', 'oauth').and_return('r')
      expect(client.get_registered_domains('ent_1')).to eq('r')
    end
  end

  describe '#get_enrollment_state' do
    it 'GETs googlepay/enrollments/{id}/state' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('googlepay/enrollments/ent_1/state', 'oauth').and_return('r')
      expect(client.get_enrollment_state('ent_1')).to eq('r')
    end
  end
end
