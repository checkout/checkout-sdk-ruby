RSpec.describe CheckoutSdk::Previous::Webhooks do
  include WebhooksHelper

  before(:each) do
    @webhook = register_webhook 'https://checkout.ruby.com/webhooks'
  end

  after(:each) do
    delete_webhook @webhook.id
  end

  describe '.retrieve_webhooks' do
    context 'when fetching all webhooks' do
      it 'should successfully return all registered webhooks', skip: 'unavailable' do
        response = previous_sdk.webhooks.retrieve_webhooks
        expect(response).not_to be_nil
      end
    end
  end

  describe '.register_webhook' do
    context 'when register a webhook' do
      it 'should successfully registered', skip: 'unavailable' do
        assert_response @webhook, %w[id
                                     url
                                     active
                                     headers
                                     content_type
                                     event_types]
      end
    end
  end

  describe '.retrieve_webhook' do
    context 'when register a webhook' do
      it 'should retrieve registered webhook', skip: 'unavailable' do
        response = previous_sdk.webhooks.retrieve_webhook @webhook.id
        assert_response response, %w[id
                                     url
                                     active
                                     headers
                                     content_type
                                     event_types]
        expect(response.url).to eq @webhook.url
      end
    end
  end

  describe '.update_webhook' do
    context 'when request update a webhook' do
      it 'should successfully update a webhook', skip: 'unavailable' do

        request = CheckoutSdk::Previous::Webhooks::WebhookRequest.new
        request.url = 'https://checkout.ruby.com/failed'
        request.headers = { authorization: '1234' }
        request.event_types = ['source_updated']
        request.active = true
        request.content_type = 'json'

        proc = -> { previous_sdk.webhooks.update_webhook @webhook.id, request }

        response = retriable(proc)
        assert_response response, %w[id
                                     url
                                     active
                                     headers
                                     content_type
                                     event_types]
        expect(response.url).to eq request.url
      end
    end
  end

  describe '.remove_webhook' do
    context 'when deleting a webhook' do
      it 'should raise error when retrieve deleted webhook', skip: 'unavailable' do
        delete_webhook @webhook.id
        expect { previous_sdk.webhooks.retrieve_webhook @webhook.id }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.http_metadata.status_code).to eq 404 }
      end
    end
  end

end
