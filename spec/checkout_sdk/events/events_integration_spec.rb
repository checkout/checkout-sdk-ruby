RSpec.describe CheckoutSdk::Previous::Webhooks do

  describe '.retrieve_all_event_types' do
    context 'when fetching event types' do
      it 'should return even types for both versions' do
        response = previous_sdk.events.retrieve_all_event_types
        expect(response).not_to be_nil
        expect(response.items).not_to be_nil
        expect(response.items[0].version).to eq '1.0'
        expect(response.items[1].version).to eq '2.0'
      end

      it 'should return even types for version one' do
        response = previous_sdk.events.retrieve_all_event_types '1.0'
        expect(response).not_to be_nil
        expect(response.items).not_to be_nil
        expect(response.items.length).to be 1
        expect(response.items[0].version).to eq '1.0'
      end
    end
  end

end
