RSpec.describe CheckoutSdk::StandaloneAccountUpdater do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::StandaloneAccountUpdater::StandaloneAccountUpdaterClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('oauth')
  end

  describe '#update_card' do
    it 'POSTs typed DTO to account-updater/cards' do
      request = CheckoutSdk::StandaloneAccountUpdater::AccountUpdaterRequest.new
      request.source_options = CheckoutSdk::StandaloneAccountUpdater::AccountUpdaterSourceOptions.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('account-updater/cards', 'oauth', request)
        .and_return('response')
      expect(client.update_card(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = {
        'source_options' => {
          'card' => { 'number' => '4242424242424242', 'expiry_month' => 12, 'expiry_year' => 2030 }
        }
      }
      expect(api_client_mock).to receive(:invoke_post)
        .with('account-updater/cards', 'oauth', hash_request)
        .and_return('response')
      expect(client.update_card(hash_request)).to eq('response')
    end
  end
end
