# frozen_string_literal: true

module WorkflowsHelper

  def create_workflow
    signature = CheckoutSdk::Workflows::WebhookSignature.new
    signature.key = '8V8x0dLK%AyD*DNS8JJr'
    signature.method = 'HMACSHA256'

    action_request = CheckoutSdk::Workflows::WebhookWorkflowAction.new
    action_request.url = 'https://google.com/fail'
    action_request.headers = {}
    action_request.signature = signature

    entity_condition_request = CheckoutSdk::Workflows::EntityWorkflowCondition.new
    entity_condition_request.entities = ['ent_kidtcgc3ge5unf4a5i6enhnr5m']

    event_condition_request = CheckoutSdk::Workflows::EventWorkflowCondition.new
    event_condition_request.events = { 'gateway' => %w[payment_approved
                                                       payment_declined
                                                       card_verification_declined
                                                       card_verified
                                                       payment_authorization_incremented
                                                       payment_authorization_increment_declined
                                                       payment_capture_declined
                                                       payment_captured
                                                       payment_refund_declined
                                                       payment_refunded
                                                       payment_void_declined
                                                       payment_voided],
                                       'dispute' => %w[dispute_canceled
                                                       dispute_evidence_required
                                                       dispute_expired
                                                       dispute_lost
                                                       dispute_resolved
                                                       dispute_won] }

    pc_condition = CheckoutSdk::Workflows::ProcessingChannelWorkflowCondition.new
    pc_condition.processing_channels = ['pc_5jp2az55l3cuths25t5p3xhwru']

    workflow_request = CheckoutSdk::Workflows::CreateWorkflow.new
    workflow_request.actions = [action_request]
    workflow_request.conditions = [entity_condition_request, event_condition_request,
                                   pc_condition]
    workflow_request.name = 'testing-ruby'
    workflow_request.active = true

    proc = -> { default_sdk.workflows.create_workflow(workflow_request) }
    response = retriable proc

    assert_response(response, ['id'])

    response
  end

  def delete_workflow(workflow_id)
    default_sdk.workflows.remove_workflow workflow_id
  end
end
