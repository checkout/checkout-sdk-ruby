RSpec.describe CheckoutSdk::Issuing do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Issuing::IssuingClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#update_cardholder' do
    it 'PATCHes issuing/cardholders/{id}' do
      req = CheckoutSdk::Issuing::UpdateCardholderRequest.new
      expect(api_client_mock).to receive(:invoke_patch)
        .with('issuing/cardholders/crh_1', 'secret_key', req).and_return('r')
      expect(client.update_cardholder('crh_1', req)).to eq('r')
    end
  end

  describe '#update_card' do
    it 'PATCHes issuing/cards/{id}' do
      req = CheckoutSdk::Issuing::UpdateCardRequest.new
      expect(api_client_mock).to receive(:invoke_patch)
        .with('issuing/cards/crd_1', 'secret_key', req).and_return('r')
      expect(client.update_card('crd_1', req)).to eq('r')
    end
  end

  describe '#renew_card' do
    it 'POSTs issuing/cards/{id}/renew' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/cards/crd_1/renew', 'secret_key', nil).and_return('r')
      expect(client.renew_card('crd_1')).to eq('r')
    end
  end

  describe '#schedule_card_revocation' do
    it 'POSTs issuing/cards/{id}/schedule-revocation' do
      req = CheckoutSdk::Issuing::ScheduleRevocationRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/cards/crd_1/schedule-revocation', 'secret_key', req).and_return('r')
      expect(client.schedule_card_revocation('crd_1', req)).to eq('r')
    end
  end

  describe '#cancel_scheduled_card_revocation' do
    it 'DELETEs issuing/cards/{id}/schedule-revocation' do
      expect(api_client_mock).to receive(:invoke_delete)
        .with('issuing/cards/crd_1/schedule-revocation', 'secret_key').and_return('r')
      expect(client.cancel_scheduled_card_revocation('crd_1')).to eq('r')
    end
  end

  describe '#simulate_refund' do
    it 'POSTs issuing/simulate/authorizations/{id}/refunds' do
      req = CheckoutSdk::Issuing::SimulateRefundRequest.new
      req.amount = 100
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/simulate/authorizations/auth_1/refunds', 'secret_key', req).and_return('r')
      expect(client.simulate_refund('auth_1', req)).to eq('r')
    end
  end

  describe 'control groups' do
    it 'create POSTs issuing/controls/control-groups' do
      req = CheckoutSdk::Issuing::AddControlGroupRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/controls/control-groups', 'secret_key', req).and_return('r')
      expect(client.create_control_group(req)).to eq('r')
    end

    it 'list GETs issuing/controls/control-groups' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('issuing/controls/control-groups', 'secret_key').and_return('r')
      expect(client.get_control_groups).to eq('r')
    end

    it 'get single GETs issuing/controls/control-groups/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('issuing/controls/control-groups/cg_1', 'secret_key').and_return('r')
      expect(client.get_control_group('cg_1')).to eq('r')
    end

    it 'delete DELETEs issuing/controls/control-groups/{id}' do
      expect(api_client_mock).to receive(:invoke_delete)
        .with('issuing/controls/control-groups/cg_1', 'secret_key').and_return('r')
      expect(client.delete_control_group('cg_1')).to eq('r')
    end
  end

  describe 'control profiles' do
    it 'create POSTs issuing/controls/control-profiles' do
      req = CheckoutSdk::Issuing::AddControlProfileRequest.new
      req.name = 'p'
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/controls/control-profiles', 'secret_key', req).and_return('r')
      expect(client.create_control_profile(req)).to eq('r')
    end

    it 'list GETs issuing/controls/control-profiles' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('issuing/controls/control-profiles', 'secret_key').and_return('r')
      expect(client.get_control_profiles).to eq('r')
    end

    it 'get single GETs issuing/controls/control-profiles/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('issuing/controls/control-profiles/cp_1', 'secret_key').and_return('r')
      expect(client.get_control_profile('cp_1')).to eq('r')
    end

    it 'update PATCHes issuing/controls/control-profiles/{id}' do
      req = CheckoutSdk::Issuing::UpdateControlProfileRequest.new
      expect(api_client_mock).to receive(:invoke_patch)
        .with('issuing/controls/control-profiles/cp_1', 'secret_key', req).and_return('r')
      expect(client.update_control_profile('cp_1', req)).to eq('r')
    end

    it 'delete DELETEs issuing/controls/control-profiles/{id}' do
      expect(api_client_mock).to receive(:invoke_delete)
        .with('issuing/controls/control-profiles/cp_1', 'secret_key').and_return('r')
      expect(client.delete_control_profile('cp_1')).to eq('r')
    end

    it 'add_target POSTs issuing/controls/control-profiles/{id}/add/{targetId}' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/controls/control-profiles/cp_1/add/crd_1', 'secret_key').and_return('r')
      expect(client.add_target_to_control_profile('cp_1', 'crd_1')).to eq('r')
    end

    it 'remove_target POSTs issuing/controls/control-profiles/{id}/remove/{targetId}' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/controls/control-profiles/cp_1/remove/crd_1', 'secret_key').and_return('r')
      expect(client.remove_target_from_control_profile('cp_1', 'crd_1')).to eq('r')
    end
  end

  describe 'issuing disputes' do
    it 'POSTs issuing/disputes' do
      req = CheckoutSdk::Issuing::CreateDisputeRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/disputes', 'secret_key', req).and_return('r')
      expect(client.create_issuing_dispute(req)).to eq('r')
    end

    it 'GETs issuing/disputes/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('issuing/disputes/dsp_1', 'secret_key').and_return('r')
      expect(client.get_issuing_dispute('dsp_1')).to eq('r')
    end

    it 'POSTs issuing/disputes/{id}/cancel' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/disputes/dsp_1/cancel', 'secret_key').and_return('r')
      expect(client.cancel_issuing_dispute('dsp_1')).to eq('r')
    end

    it 'POSTs issuing/disputes/{id}/escalate' do
      req = CheckoutSdk::Issuing::EscalateDisputeRequest.new
      req.justification = 'reason'
      expect(api_client_mock).to receive(:invoke_post)
        .with('issuing/disputes/dsp_1/escalate', 'secret_key', req).and_return('r')
      expect(client.escalate_issuing_dispute('dsp_1', req)).to eq('r')
    end
  end

  describe '#get_transactions and #get_transaction' do
    it 'GETs issuing/transactions with query' do
      query = { 'limit' => 10 }
      expect(api_client_mock).to receive(:invoke_get)
        .with('issuing/transactions', 'secret_key', query).and_return('r')
      expect(client.get_transactions(query)).to eq('r')
    end

    it 'GETs issuing/transactions/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('issuing/transactions/txn_1', 'secret_key').and_return('r')
      expect(client.get_transaction('txn_1')).to eq('r')
    end
  end

  describe '#get_digital_card' do
    it 'GETs issuing/digital-cards/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('issuing/digital-cards/dc_1', 'secret_key').and_return('r')
      expect(client.get_digital_card('dc_1')).to eq('r')
    end
  end
end
