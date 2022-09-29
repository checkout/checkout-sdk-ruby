RSpec.describe CheckoutSdk::Previous::Apm::Sepa do

  before(:example) {
    @credentials_mock = double('credentials')
    @api_client_mock = double('apì_client')
    @configuration_mock = double('configuration')
    @sepa_client = CheckoutSdk::Previous::Apm::Sepa::SepaClient.new @api_client_mock, @configuration_mock

    expect(@credentials_mock).to receive(:get_authorization).and_return('secret_key')
    expect(@configuration_mock).to receive(:credentials).and_return(@credentials_mock)
  }

  describe '.get_mandate' do
    context 'when fetching valid mandate' do
      it 'retrieves mandate details' do
        expect(@api_client_mock).to receive(:invoke_get)
                                      .with('sepa/mandates/mandate_id',
                                            'secret_key')
                                      .and_return('response')

        expect(@sepa_client.get_mandate('mandate_id')).to eq('response')
      end
    end
  end

  describe '.cancel_mandate' do
    context 'when cancelling existing mandate' do
      it 'cancels mandate' do
        expect(@api_client_mock).to receive(:invoke_post)
                                      .with('sepa/mandates/mandate_id/cancel',
                                            'secret_key')
                                      .and_return('response')

        expect(@sepa_client.cancel_mandate('mandate_id')).to eq('response')
      end
    end
  end

  describe '.get_mandate_via_ppro' do
    context 'when fetching valid mandate via ppro' do
      it 'retrieves mandate details' do
        expect(@api_client_mock).to receive(:invoke_get)
                                      .with('ppro/sepa/mandates/mandate_id',
                                            'secret_key')
                                      .and_return('response')

        expect(@sepa_client.get_mandate_via_ppro('mandate_id')).to eq('response')
      end
    end
  end

  describe '.cancel_mandate' do
    context 'when cancelling existing mandate via ppro' do
      it 'cancels mandate' do
        expect(@api_client_mock).to receive(:invoke_post)
                                      .with('ppro/sepa/mandates/mandate_id/cancel',
                                            'secret_key')
                                      .and_return('response')

        expect(@sepa_client.cancel_mandate_via_ppro('mandate_id')).to eq('response')
      end
    end
  end
end

