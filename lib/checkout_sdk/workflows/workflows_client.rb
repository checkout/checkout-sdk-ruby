# frozen_string_literal: true

module CheckoutSdk
  module Workflows
    class WorkflowsClient < Client
      WORKFLOWS = 'workflows'
      WORKFLOW = 'workflow'
      ACTIONS = 'actions'
      CONDITIONS = 'conditions'
      EVENT_TYPES = 'event-types'
      EVENTS = 'events'
      REFLOW = 'reflow'
      SUBJECT = 'subject'
      WORKFLOW_ID = 'workflowId'
      TEST = 'test'
      private_constant :WORKFLOWS, :WORKFLOW, :ACTIONS, :CONDITIONS, :EVENT_TYPES, :EVENTS, :REFLOW,
                       :SUBJECT, :WORKFLOW_ID, :TEST

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::SECRET_KEY_OR_OAUTH)
      end

      def retrieve_workflows
        api_client.invoke_get(WORKFLOWS, sdk_authorization)
      end

      # @param [Hash, CreateWorkflow] create_workflow
      def create_workflow(create_workflow)
        api_client.invoke_post(WORKFLOWS, sdk_authorization, create_workflow)
      end

      # @param [String] workflow_id
      def retrieve_workflow(workflow_id)
        api_client.invoke_get(build_path(WORKFLOWS, workflow_id), sdk_authorization)
      end

      # @param [String] workflow_id
      def remove_workflow(workflow_id)
        api_client.invoke_delete(build_path(WORKFLOWS, workflow_id), sdk_authorization)
      end

      # @param [String] workflow_id
      # @param [Hash, PatchWorkflow] patch_workflow
      def patch_workflow(workflow_id, patch_workflow)
        api_client.invoke_patch(build_path(WORKFLOWS, workflow_id), sdk_authorization, patch_workflow)
      end

      # @param [String] workflow_id
      # @param [Hash, WorkflowAction] workflow_action
      def add_workflow_action(workflow_id, workflow_action)
        api_client.invoke_post(build_path(WORKFLOWS, workflow_id, ACTIONS), sdk_authorization, workflow_action)
      end

      # @param [String] workflow_id
      # @param [String] action_id
      # @param [Hash, WorkflowAction] workflow_action
      def update_workflow_action(workflow_id, action_id, workflow_action)
        api_client.invoke_put(build_path(WORKFLOWS, workflow_id, ACTIONS, action_id), sdk_authorization,
                              workflow_action)
      end

      # @param [String] workflow_id
      # @param [String] action_id
      def remove_workflow_action(workflow_id, action_id)
        api_client.invoke_delete(build_path(WORKFLOWS, workflow_id, ACTIONS, action_id), sdk_authorization)
      end

      # @param [String] workflow_id
      # @param [Hash, WorkflowCondition] workflow_condition
      def add_workflow_condition(workflow_id, workflow_condition)
        api_client.invoke_post(build_path(WORKFLOWS, workflow_id, CONDITIONS), sdk_authorization, workflow_condition)
      end

      # @param [String] workflow_id
      # @param [String] condition_id
      # @param [Hash, WorkflowCondition] workflow_condition
      def update_workflow_condition(workflow_id, condition_id, workflow_condition)
        api_client.invoke_put(build_path(WORKFLOWS, workflow_id, CONDITIONS, condition_id), sdk_authorization,
                              workflow_condition)
      end

      # @param [String] workflow_id
      # @param [String] condition_id
      def remove_workflow_condition(workflow_id, condition_id)
        api_client.invoke_delete(build_path(WORKFLOWS, workflow_id, CONDITIONS, condition_id), sdk_authorization)
      end

      # @param [String] workflow_id
      # @param [Hash] event_types_request
      def test_workflow(workflow_id, event_types_request)
        api_client.invoke_post(build_path(WORKFLOWS, workflow_id, TEST), sdk_authorization, event_types_request)
      end

      def retrieve_event_types
        api_client.invoke_get(build_path(WORKFLOWS, EVENT_TYPES), sdk_authorization)
      end

      # @param [String] event_id
      def retrieve_event(event_id)
        api_client.invoke_get(build_path(WORKFLOWS, EVENTS, event_id), sdk_authorization)
      end

      # @param [String] event_id
      # @param [String] action_id
      def retrieve_action_invocations(event_id, action_id)
        api_client.invoke_get(build_path(WORKFLOWS, EVENTS, event_id, ACTIONS, action_id), sdk_authorization)
      end

      # @param [String] event_id
      def reflow_by_event(event_id)
        api_client.invoke_post(build_path(WORKFLOWS, EVENTS, event_id, REFLOW), sdk_authorization)
      end

      # @param [String] event_id
      # @param [String] workflow_id
      def reflow_by_event_and_workflow(event_id, workflow_id)
        api_client.invoke_post(build_path(WORKFLOWS, EVENTS, event_id, WORKFLOW, workflow_id, REFLOW),
                               sdk_authorization)
      end

      # @param [Reflow] reflow
      def reflow(reflow)
        api_client.invoke_post(build_path(WORKFLOWS, EVENTS, REFLOW), sdk_authorization, reflow)
      end

      # @param [String] subject_id
      def retrieve_subject_events(subject_id)
        api_client.invoke_get(build_path(WORKFLOWS, EVENTS, SUBJECT, subject_id), sdk_authorization)
      end

      # @param [String] subject_id
      def reflow_by_subject(subject_id)
        api_client.invoke_post(build_path(WORKFLOWS, EVENTS, SUBJECT, subject_id, REFLOW), sdk_authorization)
      end

      # @param [String] subject_id
      # @param [String] workflow_id
      def reflow_by_subject_and_workflow(subject_id, workflow_id)
        api_client.invoke_post(build_path(WORKFLOWS, EVENTS, SUBJECT, subject_id, WORKFLOW, workflow_id, REFLOW),
                               sdk_authorization)
      end
    end
  end
end
