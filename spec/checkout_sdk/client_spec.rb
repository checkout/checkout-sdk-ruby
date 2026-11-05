# frozen_string_literal: true

RSpec.describe CheckoutSdk::Client do
  let(:configuration) { double('configuration') }
  let(:client) { CheckoutSdk::Client.send(:new, double('api_client'), configuration, 'SECRET_KEY') }

  def build_path(*args)
    client.send(:build_path, *args)
  end

  describe '#build_path' do
    it 'joins plain segments with a slash' do
      expect(build_path('payments', 'pay_123', 'captures')).to eq('payments/pay_123/captures')
    end

    it 'keeps every argument as a single segment' do
      expect(build_path('payments', 'a b%c')).to eq('payments/a%20b%25c')
    end

    it 'encodes query and fragment delimiters' do
      expect(build_path('payments', 'a?b#c')).to eq('payments/a%3Fb%23c')
    end

    it 'accepts Integer and Symbol segments' do
      expect(build_path('reports', 123, :files)).to eq('reports/123/files')
    end

    [nil, '', '.', '..', '../x', 'a/b', 'a\\b', '..'.encode(Encoding::UTF_16LE)].each do |value|
      it "raises CheckoutArgumentException for #{value.inspect} (#{value.is_a?(String) ? value.encoding : value.class})" do
        expect { build_path('payments', value) }.to raise_error(CheckoutSdk::CheckoutArgumentException)
      end
    end
  end

  describe 'request path on the wire' do
    let(:requests) { [] }
    let(:api) do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        %i[get post].each do |verb|
          stub.send(verb, /.*/) do |env|
            requests << env.url
            [200, { 'Content-Type' => 'application/json' }, '{}']
          end
        end
      end
      http_client = Faraday.new { |f| f.adapter :test, stubs }
      CheckoutSdk.builder.static_keys
                 .with_secret_key('sk_sbox_m73dzbpy7cf3gfd46xr4yj5xo4e')
                 .with_environment(CheckoutSdk::Environment.sandbox)
                 .with_environment_subdomain('abc123')
                 .with_http_client(http_client)
                 .with_multipart_http_client(http_client)
                 .with_logger(Logger.new(StringIO.new))
                 .build
    end

    it 'keeps an identifier inside its own segment' do
      api.payments_setups.confirm_payment_setup('ps 1%', 'klarna')
      expect(requests.map(&:path)).to eq(['/payments/setups/ps%201%25/confirm/klarna'])
    end

    it 'sends no query or fragment taken from an identifier' do
      api.payments.get_payment_details('a?b#c')
      url = requests.first
      expect(url.path).to eq('/payments/a%3Fb%23c')
      expect(url.query).to be_nil
      expect(url.fragment).to be_nil
    end

    it 'raises before any request for an invalid payment method name' do
      expect { api.payments_setups.confirm_payment_setup('ps_x', '../../x/y') }
        .to raise_error(CheckoutSdk::CheckoutArgumentException)
      expect(requests).to be_empty
    end

    ['', '../x', '..'.encode(Encoding::UTF_16LE)].each do |value|
      it "raises before any request for the identifier #{value.inspect} (#{value.encoding})" do
        expect { api.payments.get_payment_details(value) }.to raise_error(CheckoutSdk::CheckoutArgumentException)
        expect { api.payments_setups.confirm_payment_setup(value, 'klarna') }
          .to raise_error(CheckoutSdk::CheckoutArgumentException)
        expect(requests).to be_empty
      end
    end
  end

  describe 'paths built from several constant segments' do
    let(:api_client) { double('api_client') }
    let(:credentials) { double('credentials', get_authorization: 'auth') }

    before { allow(configuration).to receive(:credentials).and_return(credentials) }

    it 'keeps the bank account field formatting path' do
      instruments = CheckoutSdk::Instruments::InstrumentsClient.new(api_client, configuration)
      query = double('query')
      expect(api_client).to receive(:invoke_get)
        .with('validation/bank-accounts/GB/GBP', 'auth', query).and_return('response')
      expect(instruments.get_bank_account_field_formatting('GB', 'GBP', query)).to eq('response')
    end

    it 'keeps the Bacs notification path' do
      bacs = CheckoutSdk::Apm::BacsClient.new(api_client, configuration)
      request = double('request')
      expect(api_client).to receive(:invoke_post)
        .with('apms/bacs/notifications', 'auth', request).and_return('response')
      expect(bacs.send_notification(request)).to eq('response')
    end

    it 'keeps the SEPA mandate paths' do
      sepa = CheckoutSdk::Previous::Apm::SepaClient.new(api_client, configuration)
      expect(api_client).to receive(:invoke_get).with('sepa/mandates/src_1', 'auth').and_return('get')
      expect(api_client).to receive(:invoke_post).with('sepa/mandates/src_1/cancel', 'auth').and_return('cancel')
      expect(api_client).to receive(:invoke_get).with('apms/ppro/sepa/mandates/src_1', 'auth').and_return('ppro_get')
      expect(api_client).to receive(:invoke_post)
        .with('apms/ppro/sepa/mandates/src_1/cancel', 'auth').and_return('ppro_cancel')
      expect(sepa.get_mandate('src_1')).to eq('get')
      expect(sepa.cancel_mandate('src_1')).to eq('cancel')
      expect(sepa.get_mandate_via_ppro('src_1')).to eq('ppro_get')
      expect(sepa.cancel_mandate_via_ppro('src_1')).to eq('ppro_cancel')
    end
  end
end
