RSpec.describe CheckoutSdk::Payments do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Payments::ApplePayClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization)
      .with(CheckoutSdk::AuthorizationType::PUBLIC_KEY).and_return('public_key')
    allow(credentials_mock).to receive(:get_authorization)
      .with(CheckoutSdk::AuthorizationType::OAUTH).and_return('oauth')
  end

  describe '#upload_certificate' do
    it 'POSTs typed DTO to applepay/certificates' do
      req = CheckoutSdk::Payments::ApplePayCertificateRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('applepay/certificates', 'public_key', req).and_return('r')
      expect(client.upload_certificate(req)).to eq('r')
    end

    it 'also accepts a raw Hash' do
      h = { 'content' => '...' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('applepay/certificates', 'public_key', h).and_return('r')
      expect(client.upload_certificate(h)).to eq('r')
    end
  end

  describe '#enroll_domain' do
    it 'POSTs typed DTO to applepay/enrollments using OAuth' do
      req = CheckoutSdk::Payments::ApplePayEnrollmentRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('applepay/enrollments', 'oauth', req).and_return('r')
      expect(client.enroll_domain(req)).to eq('r')
    end
  end

  describe '#generate_signing_request' do
    it 'POSTs typed DTO to applepay/signing-requests' do
      req = CheckoutSdk::Payments::ApplePaySigningRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('applepay/signing-requests', 'public_key', req).and_return('r')
      expect(client.generate_signing_request(req)).to eq('r')
    end
  end
end
