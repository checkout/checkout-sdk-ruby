class FakeHttpClient
end

class FakeLogger
end

RSpec.describe CheckoutSdk::StaticKeysSdkCredentials do
  before do
    @secret_key = ENV['CHECKOUT_DEFAULT_SECRET_KEY']
    @public_key = ENV['CHECKOUT_DEFAULT_PUBLIC_KEY']
    @credentials = CheckoutSdk::StaticKeysSdkCredentials.new(@secret_key, @public_key)
    @http_client = FakeHttpClient.new
    @multipart_http_client = FakeHttpClient.new
    @logger = FakeLogger.new
  end

  it 'should create configuration' do
    configuration = CheckoutSdk::CheckoutConfiguration.new(
      @credentials,
      CheckoutSdk::Environment.sandbox,
      @http_client,
      @multipart_http_client,
      @logger
    )

    expect(configuration.credentials).to eq(@credentials)
    expect(configuration.environment.base_uri).to eq(CheckoutSdk::Environment.sandbox.base_uri)
    expect(configuration.environment.base_uri).to eq("https://api.sandbox.checkout.com/")
    expect(configuration.http_client).to eq(@http_client)
    expect(configuration.environment_subdomain).to be_nil
  end

  [
    %w[123dmain https://123dmain.api.sandbox.checkout.com/],
    %w[123domain https://123domain.api.sandbox.checkout.com/],
    %w[1234domain https://1234domain.api.sandbox.checkout.com/],
    %w[12345domain https://12345domain.api.sandbox.checkout.com/]
  ].each do |subdomain, expected_url|
    it "should create configuration with subdomain #{subdomain}" do
      environment_subdomain = CheckoutSdk::EnvironmentSubdomain.new(CheckoutSdk::Environment.sandbox, subdomain)

      configuration = CheckoutSdk::CheckoutConfiguration.new(
        @credentials,
        CheckoutSdk::Environment.sandbox,
        @http_client,
        @multipart_http_client,
        @logger,
        environment_subdomain
      )

      expect(configuration.credentials).to eq(@credentials)
      expect(configuration.environment.base_uri).to eq(CheckoutSdk::Environment.sandbox.base_uri)
      expect(configuration.http_client).to eq(@http_client)
      expect(configuration.environment_subdomain.base_uri).to eq(expected_url)
    end
  end

  [
    ['', 'https://api.sandbox.checkout.com/'],
    %w[123 https://api.sandbox.checkout.com/],
    %w[123bad https://api.sandbox.checkout.com/],
    %w[12345domainBad https://api.sandbox.checkout.com/]
  ].each do |subdomain, expected_url|
    it 'should create configuration with bad subdomain #{subdomain}' do
      environment_subdomain = CheckoutSdk::EnvironmentSubdomain.new(CheckoutSdk::Environment.sandbox, subdomain)

      configuration = CheckoutSdk::CheckoutConfiguration.new(
        @credentials,
        CheckoutSdk::Environment.sandbox,
        @http_client,
        @multipart_http_client,
        @logger,
        environment_subdomain
      )

      expect(configuration.credentials).to eq(@credentials)
      expect(configuration.environment.base_uri).to eq(CheckoutSdk::Environment.sandbox.base_uri)
      expect(configuration.http_client).to eq(@http_client)
      expect(configuration.environment_subdomain.base_uri).to eq(expected_url)
    end
  end
end
