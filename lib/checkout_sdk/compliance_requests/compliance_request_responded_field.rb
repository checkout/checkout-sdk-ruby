# frozen_string_literal: true

module CheckoutSdk
  module ComplianceRequests
    # A single responded field for a compliance request. Matches swagger
    # `ComplianceRequestRespondedField`.
    #
    # @!attribute name
    #   @return [String] The field name (e.g. "date_of_birth").
    # @!attribute value
    #   The value provided for the field. Intentionally untyped per swagger
    #   (no `type` declaration, `nullable: true`), so the only valid Ruby
    #   annotation is `Object`. Concrete shape depends on the field being
    #   responded to (e.g. a date string for `date_of_birth`).
    #   @return [Object]
    # @!attribute not_available
    #   @return [Boolean] Whether the value is unavailable for this field.
    class ComplianceRequestRespondedField
      attr_accessor :name, :value, :not_available
    end
  end
end
