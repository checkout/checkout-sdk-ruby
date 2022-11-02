RSpec.describe CheckoutSdk::Workflows do
  include WorkflowsHelper, PaymentsHelper

  before(:each) do
    @workflow = create_workflow
  end

  after(:each) do
    delete_workflow @workflow.id
  end

  describe '.retrieve_action_invocations' do
    context 'when creating a workflow' do
      it 'successfully retrieve actions invocations after a payment' do
        payment_response = make_card_payment

        proc = -> { default_sdk.workflows.retrieve_subject_events(payment_response.id) }
        payment_event = retriable proc

        workflow_response = default_sdk.workflows.retrieve_workflow @workflow.id

        assert_response(workflow_response, ['actions'])

        action_invocations = default_sdk.workflows.retrieve_action_invocations(payment_event.data[0].id, workflow_response.actions[0].id)

        assert_response(action_invocations, %w[workflow_id
                                               workflow_action_id
                                               status
                                               event_id
                                               action_type
                                               action_invocations])

        expect(workflow_response.actions[0].id).to eq(action_invocations.workflow_action_id)
        expect(payment_event.data[0].id,).to eq(action_invocations.event_id)

      end
    end
  end
end
