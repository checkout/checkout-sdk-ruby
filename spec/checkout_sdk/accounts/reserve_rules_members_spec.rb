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

  describe '#add_reserve_rule' do
    it 'POSTs to accounts/entities/{id}/reserve-rules' do
      req = CheckoutSdk::Accounts::ReserveRuleCreateRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('accounts/entities/ent_1/reserve-rules', 'secret_key', req).and_return('r')
      expect(client.add_reserve_rule('ent_1', req)).to eq('r')
    end
  end

  describe '#query_reserve_rules' do
    it 'GETs accounts/entities/{id}/reserve-rules' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('accounts/entities/ent_1/reserve-rules', 'secret_key').and_return('r')
      expect(client.query_reserve_rules('ent_1')).to eq('r')
    end
  end

  describe '#get_reserve_rule' do
    it 'GETs accounts/entities/{id}/reserve-rules/{rid}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('accounts/entities/ent_1/reserve-rules/rsv_1', 'secret_key').and_return('r')
      expect(client.get_reserve_rule('ent_1', 'rsv_1')).to eq('r')
    end
  end

  describe '#update_reserve_rule' do
    it 'PUTs accounts/entities/{id}/reserve-rules/{rid}' do
      req = CheckoutSdk::Accounts::ReserveRuleUpdateRequest.new
      expect(api_client_mock).to receive(:invoke_put)
        .with('accounts/entities/ent_1/reserve-rules/rsv_1', 'secret_key', req).and_return('r')
      expect(client.update_reserve_rule('ent_1', 'rsv_1', req)).to eq('r')
    end
  end

  describe '#get_sub_entity_members' do
    it 'GETs accounts/entities/{id}/members' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('accounts/entities/ent_1/members', 'secret_key').and_return('r')
      expect(client.get_sub_entity_members('ent_1')).to eq('r')
    end
  end

  describe '#reinvite_sub_entity_member' do
    it 'PUTs accounts/entities/{id}/members/{userId}' do
      expect(api_client_mock).to receive(:invoke_put)
        .with('accounts/entities/ent_1/members/usr_1', 'secret_key', nil).and_return('r')
      expect(client.reinvite_sub_entity_member('ent_1', 'usr_1')).to eq('r')
    end
  end

  describe '#upload_entity_file' do
    it 'submits multipart to entities/{id}/files via files_client' do
      req = CheckoutSdk::Accounts::EntityFilesRequest.new
      expect(files_client_mock).to receive(:submit_file)
        .with('entities/ent_1/files', 'secret_key', req).and_return('r')
      expect(client.upload_entity_file('ent_1', req)).to eq('r')
    end
  end

  describe '#get_entity_file' do
    it 'GETs entities/{id}/files/{fileId} via files_client' do
      expect(files_client_mock).to receive(:invoke_get)
        .with('entities/ent_1/files/file_1', 'secret_key').and_return('r')
      expect(client.get_entity_file('ent_1', 'file_1')).to eq('r')
    end
  end
end
