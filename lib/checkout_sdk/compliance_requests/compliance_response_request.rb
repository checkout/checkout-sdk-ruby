# frozen_string_literal: true

module CheckoutSdk
  module ComplianceRequests
    # Request body for POST /compliance-requests/{payment_id}.
    # Used to respond to a compliance information request raised against a payment.
    #
    # @!attribute fields
    #   @return [ComplianceRequestRespondedFields]
    # @!attribute comments
    #   @return [String] Optional free-text comment.
    class ComplianceResponseRequest
      attr_accessor :fields, :comments
    end
  end
end
