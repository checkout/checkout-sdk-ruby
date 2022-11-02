RSpec.describe CheckoutSdk::Workflows do
  include WorkflowsHelper

  before(:all) do
    @workflow = create_workflow
  end

  after(:all) do
    delete_workflow @workflow.id
  end

  describe '.retrieve_workflows' do
    context 'when fetching for workflows' do
      it 'should successfully retrieve workflows information' do
        workflows = default_sdk.workflows.retrieve_workflows
        workflows.data.each do |workflow|
          assert_response(workflow, %w[id name active _links])
        end
      end
    end
  end

  describe '.retrieve_workflow' do
    context 'when having a workflow' do
      it 'should successfully retrieve workflow details' do
        workflow_response = default_sdk.workflows.retrieve_workflow @workflow.id
        assert_response(workflow_response, %w[id name active actions conditions])

        workflow_response.actions.each do |action|
          assert_response(action, %w[id type url headers signature])
        end

        workflow_response.conditions.each do |condition|
          assert_response(condition, %w[id type])
          if condition.type == 'event'
            expect(condition.events).not_to be_nil
            expect(condition.events.instance_variable_get(:@table).size).to be > 0
          end
          if condition.type == 'events'
            expect(condition.entities).not_to be_nil
            expect(condition.entities.instance_variable_get(:@table).size).to be > 0
          end
          if condition.type == 'processing_channel'
            expect(condition.processing_channels).not_to be_nil
            expect(condition.processing_channels.size).to be > 0
          end
        end
      end
    end
  end

  describe '.patch_workflow' do
    context 'when having a workflow' do
      it 'should successfully patch workflow' do
        patch_workflow = CheckoutSdk::Workflows::PatchWorkflow.new
        patch_workflow.name = 'python_testing_2'
        patch_workflow.active = false

        response = default_sdk.workflows.patch_workflow(@workflow.id, patch_workflow)
        expect(response).not_to be_nil
        expect(response.name).to eq(patch_workflow.name)
        expect(response.active).to eq(patch_workflow.active)
      end
    end
  end

  describe '.update_workflow_action' do
    context 'when having a workflow' do
      it 'should update workflow action' do
        workflow_response = default_sdk.workflows.retrieve_workflow @workflow.id
        assert_response(workflow_response, %w[id name active actions conditions])

        signature = CheckoutSdk::Workflows::WebhookSignature.new
        signature.key = '8V8x0dLK%AyD*DNS8JJr'
        signature.method = 'HMACSHA256'

        action_request = CheckoutSdk::Workflows::WebhookWorkflowAction.new
        action_request.url = 'https://google.com/fail/fake'
        action_request.signature = signature

        default_sdk.workflows.update_workflow_action(@workflow.id, workflow_response.actions[0].id, action_request)
        updated_workflow = default_sdk.workflows.retrieve_workflow @workflow.id
        expect(updated_workflow).not_to be_nil
        expect(updated_workflow.actions[0].url).to eq(action_request.url)
      end
    end
  end

end
