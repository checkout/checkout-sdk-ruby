# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Request body for PUT /accounts/entities/{id}/requirements/{requirementId}.
    #
    # The expected shape of `value` is defined by the JSON Schema returned in
    # the requirement details response. Common shapes include a file reference
    # (e.g. { "file_id": "file_..." }), a primitive value, or a structured object.
    #
    # @!attribute value
    #   @return [Object] The response to the requirement (any JSON-serialisable value).
    class EntityRequirementUpdateRequest
      attr_accessor :value
    end
  end
end
