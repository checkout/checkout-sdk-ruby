# frozen_string_literal: true

RSpec.describe CheckoutSdk::OAuthSdkCredentials do
  let(:client_secret) { 'oauth-client-secret-value' }
  let(:authorization_uri) { 'https://access.sandbox.checkout.com/connect/token' }

  def build_credentials(stubs)
    http_client = Faraday.new do |f|
      f.response :raise_error
      f.adapter :test, stubs
    end
    described_class.new('ack_client_id', client_secret, [CheckoutSdk::OAuthScopes::GATEWAY], http_client,
                        CheckoutSdk::Environment.sandbox, Logger.new(StringIO.new), authorization_uri)
  end

  def token_stubs(status, body)
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.post('/connect/token') { [status, { 'Content-Type' => 'application/json' }, body] }
    end
  end

  context 'when the token response is successful' do
    it 'builds the access token' do
      body = '{"access_token":"token-value","token_type":"Bearer","expires_in":3600}'
      credentials = build_credentials(token_stubs(200, body))

      expect(credentials.access_token.token).to eq('token-value')
    end
  end

  context 'when the token response does not indicate success' do
    [400, 401, 429, 500].each do |status|
      it "error message omits credentials for status #{status}" do
        expect { build_credentials(token_stubs(status, '{"error":"invalid_client"}')) }
          .to raise_error(CheckoutSdk::CheckoutAuthorizationException) do |error|
            [error.message, error.inspect, error.full_message].each do |text|
              expect(text).not_to include(client_secret)
              expect(text).not_to include('grant_type=')
            end
            expect(error.cause).to be_nil
          end
      end
    end

    it 'builds the message from status and body' do
      expect { build_credentials(token_stubs(401, '{"error":"invalid_client"}')) }
        .to raise_error(CheckoutSdk::CheckoutAuthorizationException,
                        'The OAuth token response status code (401) does not indicate success. ' \
                        'Details: error: invalid_client.')
    end

    it 'keeps a body that is not JSON in the message' do
      expect { build_credentials(token_stubs(400, 'Bad Request')) }
        .to raise_error(CheckoutSdk::CheckoutAuthorizationException,
                        'The OAuth token response status code (400) does not indicate success. Details: Bad Request.')
    end

    it 'exposes the response status, headers and body' do
      expect { build_credentials(token_stubs(429, '{"error":"rate_limited"}')) }
        .to raise_error(CheckoutSdk::CheckoutAuthorizationException) do |error|
          expect(error.http_metadata.status_code).to eq(429)
          expect(error.http_metadata.headers['Content-Type']).to eq('application/json')
          expect(error.http_metadata.body).to eq('{"error":"rate_limited"}')
        end
    end
  end

  context 'when the token request times out' do
    it 're-raises the timeout unchanged' do
      stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.post('/connect/token') { raise Faraday::TimeoutError }
      end

      expect { build_credentials(stubs) }.to raise_error(Faraday::TimeoutError)
    end
  end
end
