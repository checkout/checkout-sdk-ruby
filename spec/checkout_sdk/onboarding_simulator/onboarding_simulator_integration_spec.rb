RSpec.describe CheckoutSdk::OnboardingSimulator do
  skip 'Requires sandbox OAuth credentials with the `accounts` scope and a seeded entity' do
    let(:client) { oauth_sdk.onboarding_simulator }

    describe '#list_available_requirements' do
      it 'returns the catalogue of requirement fields' do
        response = client.list_available_requirements
        expect(response).not_to be_nil
      end
    end

    describe '#list_scenarios' do
      it 'returns the catalogue of scenarios' do
        response = client.list_scenarios
        expect(response).not_to be_nil
      end
    end

    describe '#run_scenario' do
      it 'executes a scenario against an entity' do
        response = client.run_scenario(ENV['CHECKOUT_ONBOARDING_ENTITY_ID'], 'scn_pass')
        expect(response).not_to be_nil
      end
    end

    describe '#set_requirements_due' do
      it 'marks requirement fields as due' do
        request = CheckoutSdk::OnboardingSimulator::SimulatorSetRequirementsDueRequest.new
        request.field_names = ['individual.date_of_birth']
        response = client.set_requirements_due(ENV['CHECKOUT_ONBOARDING_ENTITY_ID'], request)
        expect(response).not_to be_nil
      end
    end

    describe '#set_entity_status' do
      it 'forces an entity to the requested status' do
        request = CheckoutSdk::OnboardingSimulator::SimulatorSetStatusRequest.new
        request.status = 'active'
        response = client.set_entity_status(ENV['CHECKOUT_ONBOARDING_ENTITY_ID'], request)
        expect(response).not_to be_nil
      end
    end
  end
end
