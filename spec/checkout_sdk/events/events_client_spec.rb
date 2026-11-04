# frozen_string_literal: true

RSpec.describe CheckoutSdk::Previous::Events::EventsClient do
  let(:api_client) { instance_double(CheckoutSdk::ApiClient) }
  let(:authorization) { CheckoutSdk::SdkAuthorization.new(CheckoutSdk::PlatformType::PREVIOUS, 'sk_test') }
  let(:client) do
    client = described_class.allocate
    allow(client).to receive(:api_client).and_return(api_client)
    allow(client).to receive(:sdk_authorization).and_return(authorization)
    client
  end

  describe '#retrieve_all_event_types' do
    it 'encodes the version query value' do
      expect(api_client).to receive(:invoke_get).with('event-types', authorization, 'version=1.0%26x%3Dy%23z')

      client.retrieve_all_event_types('1.0&x=y#z')
    end

    it 'sends no query without a version' do
      expect(api_client).to receive(:invoke_get).with('event-types', authorization, nil)

      client.retrieve_all_event_types
    end
  end
end
