# frozen_string_literal: true

module CheckoutSdk
  module Disputes
    # @!attribute proof_of_delivery_or_service_file
    #   @return [String]
    # @!attribute proof_of_delivery_or_service_text
    #   @return [String]
    # @!attribute invoice_or_receipt_file
    #   @return [String]
    # @!attribute invoice_or_receipt_text
    #   @return [String]
    # @!attribute invoice_showing_distinct_transactions_file
    #   @return [String]
    # @!attribute invoice_showing_distinct_transactions_text
    #   @return [String]
    # @!attribute customer_communication_file
    #   @return [String]
    # @!attribute customer_communication_text
    #   @return [String]
    # @!attribute refund_or_cancellation_policy_file
    #   @return [String]
    # @!attribute refund_or_cancellation_policy_text
    #   @return [String]
    # @!attribute recurring_transaction_agreement_file
    #   @return [String]
    # @!attribute recurring_transaction_agreement_text
    #   @return [String]
    # @!attribute invoice_showing_distinct_transactions_file
    #   @return [String]
    # @!attribute invoice_showing_distinct_transactions_text
    #   @return [String]
    # @!attribute additional_evidence_file
    #   @return [String]
    # @!attribute additional_evidence_text
    #   @return [String]
    # @!attribute proof_of_delivery_or_service_date_file
    #   @return [String]
    # @!attribute proof_of_delivery_or_service_date_text
    #   @return [String]
    class DisputeEvidenceRequest
      attr_accessor :proof_of_delivery_or_service_file,
                    :proof_of_delivery_or_service_text,
                    :invoice_or_receipt_file,
                    :invoice_or_receipt_text,
                    :invoice_showing_distinct_transactions_file,
                    :invoice_showing_distinct_transactions_text,
                    :customer_communication_file,
                    :customer_communication_text,
                    :refund_or_cancellation_policy_file,
                    :refund_or_cancellation_policy_text,
                    :recurring_transaction_agreement_file,
                    :recurring_transaction_agreement_text,
                    :additional_evidence_file,
                    :additional_evidence_text,
                    :proof_of_delivery_or_service_date_file,
                    :proof_of_delivery_or_service_date_text
    end
  end
end
