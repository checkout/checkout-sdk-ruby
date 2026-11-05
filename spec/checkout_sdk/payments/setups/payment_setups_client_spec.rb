RSpec.describe CheckoutSdk::Payments do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Payments::PaymentSetupsClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('secret_key')
  end

  describe '#create_payment_setup' do
    it 'POSTs an opaque request object to payments/setups' do
      request = double('request')
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/setups', 'secret_key', request).and_return('response')
      expect(client.create_payment_setup(request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'amount' => 1000, 'currency' => 'GBP' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/setups', 'secret_key', hash_request).and_return('response')
      expect(client.create_payment_setup(hash_request)).to eq('response')
    end
  end

  describe '#update_payment_setup' do
    it 'PUTs payments/setups/{id}' do
      request = double('request')
      expect(api_client_mock).to receive(:invoke_put)
        .with('payments/setups/ps_1', 'secret_key', request).and_return('response')
      expect(client.update_payment_setup('ps_1', request)).to eq('response')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'amount' => 2000 }
      expect(api_client_mock).to receive(:invoke_put)
        .with('payments/setups/ps_1', 'secret_key', hash_request).and_return('response')
      expect(client.update_payment_setup('ps_1', hash_request)).to eq('response')
    end
  end

  describe '#get_payment_setup' do
    it 'GETs payments/setups/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('payments/setups/ps_1', 'secret_key').and_return('response')
      expect(client.get_payment_setup('ps_1')).to eq('response')
    end
  end

  describe '#confirm_payment_setup' do
    it 'POSTs payments/setups/{id}/confirm/{payment_method_name}' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/setups/ps_1/confirm/klarna', 'secret_key').and_return('response')
      expect(client.confirm_payment_setup('ps_1', 'klarna')).to eq('response')
    end

    it 'builds the correct path for a card payment method name' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/setups/ps_1/confirm/card', 'secret_key').and_return('response')
      expect(client.confirm_payment_setup('ps_1', 'card')).to eq('response')
    end

    it 'builds the correct path for the cashapp payment method name' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/setups/ps_1/confirm/cashapp', 'secret_key').and_return('response')
      expect(client.confirm_payment_setup('ps_1', 'cashapp')).to eq('response')
    end

    it 'accepts names with underscores and digits, any case, or a Symbol' do
      { 'alipay_cn' => 'alipay_cn', 'p24' => 'p24', 'Card' => 'Card', klarna: 'klarna' }.each do |name, segment|
        expect(api_client_mock).to receive(:invoke_post)
          .with("payments/setups/ps_1/confirm/#{segment}", 'secret_key').and_return('response')
        expect(client.confirm_payment_setup('ps_1', name)).to eq('response')
      end
    end

    [nil, '', 'a/b', '../x', 'a?b', 'a#b', 'a b', 'a.b', 'a-b'].each do |name|
      it "raises CheckoutArgumentException for #{name.inspect} without sending a request" do
        expect(api_client_mock).not_to receive(:invoke_post)
        expect { client.confirm_payment_setup('ps_1', name) }
          .to raise_error(CheckoutSdk::CheckoutArgumentException, 'Invalid payment method name')
      end
    end

    it 'raises CheckoutArgumentException for an empty id without sending a request' do
      expect(api_client_mock).not_to receive(:invoke_post)
      expect { client.confirm_payment_setup('', 'klarna') }.to raise_error(CheckoutSdk::CheckoutArgumentException)
    end
  end

  describe '#create_payment_setup with billing_descriptor, presentment_details and terminal' do
    it 'passes billing_descriptor, presentment_details and terminal through untouched' do
      request = {
        amount: 1000,
        currency: 'GBP',
        billing_descriptor: {
          name: 'Checkout.com',
          city: 'London',
          reference: 'Payment for order 123456'
        },
        presentment_details: {
          amount: 110,
          currency: 'EUR'
        },
        terminal: {
          id: '12345678',
          local_date_time: '2026-05-26T13:05:14+01:00'
        }
      }
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/setups', 'secret_key', request).and_return('response')
      expect(client.create_payment_setup(request)).to eq('response')
    end
  end

  describe '#create_payment_setup with Cash App Pay, customer and device' do
    it 'passes payment_methods.cashapp and the customer fields through untouched' do
      request = {
        processing_channel_id: 'pc_aaaaaaaaaaaaaaaaaaaaaaaaaa',
        amount: 1000,
        currency: 'USD',
        payment_methods: { cashapp: { initialization: 'enabled', customer_profile_sharing: true } },
        customer: {
          id: 'cus_123456789',
          country: 'GB',
          tax_number: 'GB123456789',
          device: {
            locale: 'en_US',
            fingerprint: 'fp_abc123xyz',
            ipv4: '203.0.113.0',
            ipv6: '2001:db8:85a3::8a2e:370:7334',
            client: CheckoutSdk::Payments::PaymentSetupDeviceClient::WEB,
            os: CheckoutSdk::Payments::PaymentSetupDeviceOs::ANDROID
          }
        }
      }
      expect(api_client_mock).to receive(:invoke_post)
        .with('payments/setups', 'secret_key', request).and_return('response')
      expect(client.create_payment_setup(request)).to eq('response')
    end
  end
end
