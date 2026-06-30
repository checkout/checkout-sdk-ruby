RSpec.describe CheckoutSdk::OnboardingSimulator do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::OnboardingSimulator::OnboardingSimulatorClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('oauth')
  end

  describe '#set_requirements_due' do
    it 'POSTs typed DTO to simulate/entities/{id}/requirements-due' do
      request = CheckoutSdk::OnboardingSimulator::SimulatorSetRequirementsDueRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('simulate/entities/ent_123/requirements-due', 'oauth', request)
        .and_return('response')
      expect(client.set_requirements_due('ent_123', request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'field_names' => ['individual.date_of_birth'] }
      expect(api_client_mock).to receive(:invoke_post)
        .with('simulate/entities/ent_123/requirements-due', 'oauth', hash_request)
        .and_return('response')
      expect(client.set_requirements_due('ent_123', hash_request)).to eq('response')
    end
  end

  describe '#run_scenario' do
    it 'POSTs to simulate/entities/{id}/scenarios/{scenario_id}' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('simulate/entities/ent_123/scenarios/scn_42', 'oauth')
        .and_return('response')
      expect(client.run_scenario('ent_123', 'scn_42')).to eq('response')
    end
  end

  describe '#set_entity_status' do
    it 'POSTs typed DTO to simulate/entities/{id}/status' do
      request = CheckoutSdk::OnboardingSimulator::SimulatorSetStatusRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('simulate/entities/ent_123/status', 'oauth', request)
        .and_return('response')
      expect(client.set_entity_status('ent_123', request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'status' => 'active' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('simulate/entities/ent_123/status', 'oauth', hash_request)
        .and_return('response')
      expect(client.set_entity_status('ent_123', hash_request)).to eq('response')
    end
  end

  describe '#list_available_requirements' do
    it 'GETs simulate/requirements-due' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('simulate/requirements-due', 'oauth')
        .and_return('response')
      expect(client.list_available_requirements).to eq('response')
    end
  end

  describe '#list_scenarios' do
    it 'GETs simulate/scenarios' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('simulate/scenarios', 'oauth')
        .and_return('response')
      expect(client.list_scenarios).to eq('response')
    end
  end
end
