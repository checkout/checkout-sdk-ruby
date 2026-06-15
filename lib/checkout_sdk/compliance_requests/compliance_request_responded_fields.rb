# frozen_string_literal: true

module CheckoutSdk
  module ComplianceRequests
    # Groups responded fields by party (sender/recipient).
    #
    # @!attribute sender
    #   @return [Array<ComplianceRequestRespondedField>]
    # @!attribute recipient
    #   @return [Array<ComplianceRequestRespondedField>]
    class ComplianceRequestRespondedFields
      attr_accessor :sender, :recipient
    end
  end
end
