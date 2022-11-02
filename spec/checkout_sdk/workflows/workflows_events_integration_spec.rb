RSpec.describe CheckoutSdk::Workflows do
  include WorkflowsHelper, PaymentsHelper

  before(:all) do
    @workflow = create_workflow
  end

  after(:all) do
    delete_workflow @workflow.id
  end

  describe '.retrieve_event_types' do
    context 'when fetching workflows event types' do
      it 'successfully retrieve event types' do
        event_types = default_sdk.workflows.retrieve_event_types
        expect(event_types).not_to be_nil
        expect(event_types.items.length).to be >= 7
      end
    end
  end

  describe '.retrieve_event' do
    context 'when creates a workflow and after a payment' do
      it 'should get subject event and events' do
        payment_response = make_card_payment(capture: true)

        proc = -> { default_sdk.workflows.retrieve_subject_events(payment_response.id) }
        predicate = ->(response) { there_are_two_events(response) }

        payment_event = retriable(proc, predicate)

        payment_event.data.each do |event|
          assert_response(event, %w[id type timestamp])

          get_event = default_sdk.workflows.retrieve_event event.id
          assert_response(get_event, %w[id source type timestamp version data])
        end
      end
    end
  end

end

def there_are_two_events(response)
  !response.data.nil? && response.data.length == 2
end
