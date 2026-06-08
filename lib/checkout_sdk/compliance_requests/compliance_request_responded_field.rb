# frozen_string_literal: true

module CheckoutSdk
  module ComplianceRequests
    # A single responded field for a compliance request.
    #
    # @!attribute name
    #   @return [String] The field name (e.g. "date_of_birth").
    # @!attribute value
    #   @return [Object] The value provided for the field.
    # @!attribute not_available
    #   @return [Boolean] Whether the value is unavailable for this field.
    class ComplianceRequestRespondedField
      attr_accessor :name, :value, :not_available
    end
  end
end
