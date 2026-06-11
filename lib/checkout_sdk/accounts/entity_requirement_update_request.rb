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
    #   The response to the requirement. Polymorphic per swagger
    #   (`oneOf [object, array, string, number, boolean]`), so the only valid
    #   Ruby annotation is `Object`. The concrete shape is dictated at runtime
    #   by the requirement's `_schema` returned from
    #   `GET /accounts/entities/{id}/requirements/{requirementId}`.
    #   @return [Object]
    class EntityRequirementUpdateRequest
      attr_accessor :value
    end
  end
end
