RSpec.describe CheckoutSdk::Apm do

  describe '.get_info' do
    context 'when trying to fetch ideal info' do
      it 'retrieves ideal info' do
        credentials_mock = double('credentials')
        api_client_mock = double('apì_client')
        configuration_mock = double('configuration')

        expect(credentials_mock).to receive(:get_authorization).and_return('secret_key')
        expect(configuration_mock).to receive(:credentials).and_return(credentials_mock)
        expect(api_client_mock).to receive(:invoke_get).with('ideal-external', 'secret_key').and_return('response')

        ideal_client = CheckoutSdk::Apm::IdealClient.new api_client_mock, configuration_mock

        expect(ideal_client.info).to eq('response')
      end
    end
  end

  describe '.get_issuers' do
    context 'when trying to fetch ideal issuers' do
      it 'retrieves ideal info' do
        credentials_mock = double('credentials')
        api_client_mock = double('apì_client')
        configuration_mock = double('configuration')

        expect(credentials_mock).to receive(:get_authorization).and_return('secret_key')
        expect(configuration_mock).to receive(:credentials).and_return(credentials_mock)
        expect(api_client_mock).to receive(:invoke_get).with('ideal-external/issuers', 'secret_key').and_return('response')

        ideal_client = CheckoutSdk::Apm::IdealClient.new api_client_mock, configuration_mock

        expect(ideal_client.issuers).to eq('response')
      end
    end
  end
end
