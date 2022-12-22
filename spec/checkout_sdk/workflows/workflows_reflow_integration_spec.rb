RSpec.describe CheckoutSdk::Workflows do
  include WorkflowsHelper, PaymentsHelper

  before(:each) do
    @workflow = create_workflow
  end

  after(:each) do
    delete_workflow @workflow.id
  end

  skip '.reflow_by_event' do
    context 'when having a workflow and after a payment' do
      it 'should successfully reflow by event' do
        payment_response = make_card_payment
        payment_event = retrieve_subject_event payment_response.id
        response = default_sdk.workflows.reflow_by_event payment_event.id
        expect(response.metadata.status_code).to eq 202
      end
    end
  end

  skip '.reflow_by_subject' do
    context 'when having a workflow and after a payment' do
      it 'should successfully reflow by subject' do
        payment_response = make_card_payment
        proc = -> { default_sdk.workflows.reflow_by_subject(payment_response.id) }
        response = retriable proc
        expect(response.metadata.status_code).to eq 202
      end
    end
  end

  skip '.reflow_by_event_and_workflow' do
    context 'when having a workflow and after a payment' do
      it 'should successfully reflow by event and workflow' do
        payment_response = make_card_payment
        payment_event = retrieve_subject_event payment_response.id
        proc = -> { default_sdk.workflows.reflow_by_event_and_workflow(payment_event.id, @workflow.id) }
        response = retriable proc
        expect(response.metadata.status_code).to eq 202
      end
    end
  end

  skip '.reflow_by_subject_and_workflow' do
    context 'when having a workflow and after a payment' do
      it 'should successfully reflow by subject and workflow' do
        payment_response = make_card_payment
        proc = -> { default_sdk.workflows.reflow_by_subject_and_workflow(payment_response.id, @workflow.id) }
        response = retriable proc
        expect(response.metadata.status_code).to eq 202
      end
    end
  end

  skip '.reflow' do
    context 'when having a workflow and after a payment' do
      it 'should successfully reflow by event request' do
        payment_response = make_card_payment
        payment_event = retrieve_subject_event payment_response.id

        request = CheckoutSdk::Workflows::ReflowByEvents.new
        request.events = [payment_event.id]
        request.workflows = [@workflow.id]

        proc = -> { default_sdk.workflows.reflow(request) }
        response = retriable proc
        expect(response.metadata.status_code).to eq 202
      end
    end
  end

end

def retrieve_subject_event(subject_id)
  proc = -> { default_sdk.workflows.retrieve_subject_events(subject_id) }
  predicate = ->(response) { payment_is_approved(response) }

  response = retriable(proc, predicate)
  find_payment_approved(response)[0]
end

def payment_is_approved(response)
  !response.data.nil? && response.data.length == 1 && !find_payment_approved(response).empty?
end

def find_payment_approved(response)
  response.data.select { |event| event.type == 'payment_approved' }
end
