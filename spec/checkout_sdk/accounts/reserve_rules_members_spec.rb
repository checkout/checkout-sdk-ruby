RSpec.describe CheckoutSdk::Accounts do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:files_client_mock) { double('files_client') }
  let(:configuration_mock) { double('configuration') }
  let(:entity_id) { 'ent_ovpg62ssyywodc4veodhelfrpv' }
  let(:user_id) { 'usr_nlmuxfhamdp6jbjnxy6c4yg6jt' }
  let(:reserve_rule_id) { 'rsv_ajm6t2mhntqmacybvmzkyjh5lw' }
  let(:instrument_id) { 'ppi_d5i6yil5666tyrglkvnjuhwon3' }
  let(:file_id) { 'file_6lbss42ezvoufcb2beo76rvwly' }
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
        .with("accounts/entities/#{entity_id}/reserve-rules", 'secret_key', req).and_return('r')
      expect(client.add_reserve_rule(entity_id, req)).to eq('r')
    end
  end

  describe '#query_reserve_rules' do
    it 'GETs accounts/entities/{id}/reserve-rules' do
      expect(api_client_mock).to receive(:invoke_get)
        .with("accounts/entities/#{entity_id}/reserve-rules", 'secret_key').and_return('r')
      expect(client.query_reserve_rules(entity_id)).to eq('r')
    end
  end

  describe '#get_reserve_rule' do
    it 'GETs accounts/entities/{id}/reserve-rules/{rid}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with("accounts/entities/#{entity_id}/reserve-rules/#{reserve_rule_id}", 'secret_key').and_return('r')
      expect(client.get_reserve_rule(entity_id, reserve_rule_id)).to eq('r')
    end
  end

  describe '#update_reserve_rule' do
    it 'PUTs accounts/entities/{id}/reserve-rules/{rid} forwarding the etag as If-Match' do
      req = CheckoutSdk::Accounts::ReserveRuleUpdateRequest.new
      etag = 'W/"3a-fXqMK..."'
      expect(api_client_mock).to receive(:invoke_put) do |path, auth, body, headers|
        expect(path).to eq("accounts/entities/#{entity_id}/reserve-rules/#{reserve_rule_id}")
        expect(auth).to eq('secret_key')
        expect(body).to eq(req)
        expect(headers).to be_a(CheckoutSdk::Common::Headers)
        expect(headers.if_match).to eq(etag)
        'r'
      end
      expect(client.update_reserve_rule(entity_id, reserve_rule_id, etag, req)).to eq('r')
    end

    it 'omits the Headers container when no etag is provided' do
      req = CheckoutSdk::Accounts::ReserveRuleUpdateRequest.new
      expect(api_client_mock).to receive(:invoke_put)
        .with("accounts/entities/#{entity_id}/reserve-rules/#{reserve_rule_id}", 'secret_key', req, nil)
        .and_return('r')
      expect(client.update_reserve_rule(entity_id, reserve_rule_id, nil, req)).to eq('r')
    end

    it 'omits the Headers container when etag is an empty string' do
      req = CheckoutSdk::Accounts::ReserveRuleUpdateRequest.new
      expect(api_client_mock).to receive(:invoke_put)
        .with("accounts/entities/#{entity_id}/reserve-rules/#{reserve_rule_id}", 'secret_key', req, nil)
        .and_return('r')
      expect(client.update_reserve_rule(entity_id, reserve_rule_id, '', req)).to eq('r')
    end
  end

  describe '#get_sub_entity_members' do
    it 'GETs accounts/entities/{id}/members' do
      expect(api_client_mock).to receive(:invoke_get)
        .with("accounts/entities/#{entity_id}/members", 'secret_key').and_return('r')
      expect(client.get_sub_entity_members(entity_id)).to eq('r')
    end
  end

  describe '#reinvite_sub_entity_member' do
    it 'PUTs accounts/entities/{id}/members/{userId} with the required body' do
      body = {}
      expect(api_client_mock).to receive(:invoke_put)
        .with("accounts/entities/#{entity_id}/members/#{user_id}", 'secret_key', body).and_return('r')
      expect(client.reinvite_sub_entity_member(entity_id, user_id, body)).to eq('r')
    end

    it 'raises when called without a body (required by swagger)' do
      expect { client.reinvite_sub_entity_member(entity_id, user_id) }
        .to raise_error(ArgumentError, /wrong number of arguments/)
    end
  end

  describe '#upload_entity_file' do
    it 'posts JSON to entities/{id}/files via files_client' do
      req = CheckoutSdk::Accounts::EntityFilesRequest.new
      expect(files_client_mock).to receive(:invoke_post)
        .with("entities/#{entity_id}/files", 'secret_key', req).and_return('r')
      expect(client.upload_entity_file(entity_id, req)).to eq('r')
    end
  end

  describe '#get_entity_file' do
    it 'GETs entities/{id}/files/{fileId} via files_client' do
      expect(files_client_mock).to receive(:invoke_get)
        .with("entities/#{entity_id}/files/#{file_id}", 'secret_key').and_return('r')
      expect(client.get_entity_file(entity_id, file_id)).to eq('r')
    end
  end

  describe '#update_payment_instrument' do
    let(:path) { "accounts/entities/#{entity_id}/payment-instruments/#{instrument_id}" }

    it 'PATCHes the request and sends headers.if_match as the If-Match header' do
      req = CheckoutSdk::Accounts::UpdatePaymentInstrumentRequest.new
      req.label = 'Renamed account'
      req.headers = CheckoutSdk::Common::Headers.new
      req.headers.if_match = '"Y3Y9MCZydj0w"'
      expect(api_client_mock).to receive(:invoke_patch).with(path, 'secret_key', req, req.headers).and_return('r')
      expect(client.update_payment_instrument(entity_id, instrument_id, req)).to eq('r')
    end

    it 'accepts a Hash request and builds the If-Match header from it' do
      req = { label: 'Renamed account', headers: { if_match: '"Y3Y9MCZydj0w"' } }
      expect(api_client_mock).to receive(:invoke_patch) do |called_path, auth, body, headers|
        expect([called_path, auth, body]).to eq([path, 'secret_key', req])
        expect(headers.if_match).to eq('"Y3Y9MCZydj0w"')
        'r'
      end
      expect(client.update_payment_instrument(entity_id, instrument_id, req)).to eq('r')
    end
  end
end
