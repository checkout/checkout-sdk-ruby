# frozen_string_literal: true

RSpec.describe CheckoutSdk::Apm::BacsClient do
  describe '.send_notification' do
    context 'when sending a Bacs Direct Debit pre-notification' do
      it 'posts to apms/bacs/notifications with secret key authorization' do
        credentials_mock = double('credentials')
        api_client_mock = double('api_client')
        configuration_mock = double('configuration')

        request = CheckoutSdk::Apm::BacsNotificationRequest.new

        # The endpoint is declared ApiSecretKey in the specification: the client must
        # ask for SECRET_KEY authorization, not OAuth.
        expect(credentials_mock).to receive(:get_authorization)
          .with(CheckoutSdk::AuthorizationType::SECRET_KEY)
          .and_return('secret_key')
        expect(configuration_mock).to receive(:credentials).and_return(credentials_mock)
        expect(api_client_mock).to receive(:invoke_post)
          .with('apms/bacs/notifications', 'secret_key', request)
          .and_return('response')

        bacs_client = described_class.new api_client_mock, configuration_mock

        expect(bacs_client.send_notification(request)).to eq('response')
      end
    end
  end

  describe 'registration' do
    it 'is exposed on the current API and absent from the previous API' do
      sdk = CheckoutSdk.builder
                       .static_keys
                       .with_secret_key(ENV.fetch('CHECKOUT_DEFAULT_SECRET_KEY', nil))
                       .with_environment(CheckoutSdk::Environment.sandbox)
                       .with_environment_subdomain('12345domain')
                       .build

      expect(sdk.bacs).to be_a(CheckoutSdk::Apm::BacsClient)
      expect(sdk).to respond_to(:bacs)

      # Bacs Direct Debit instruments and notifications are current-API only.
      expect(CheckoutSdk::Previous::CheckoutApi.instance_methods).not_to include(:bacs)
    end
  end
end
