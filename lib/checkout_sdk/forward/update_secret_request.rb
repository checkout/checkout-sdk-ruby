# frozen_string_literal: true

module CheckoutSdk
  module Forward
    # Request body for PATCH /secrets/{name}.
    #
    # @!attribute value
    #   @return [String] New plaintext secret value (max 8KB).
    # @!attribute entity_id
    #   @return [String] Update the entity scope.
    class UpdateSecretRequest
      attr_accessor :value, :entity_id
    end
  end
end
