# frozen_string_literal: true

module CheckoutSdk
  module Forward
    # Request body for POST /secrets.
    #
    # @!attribute name
    #   @return [String] Secret name (1-64 alphanumeric chars).
    # @!attribute value
    #   @return [String] Plaintext secret value (max 8KB).
    # @!attribute entity_id
    #   @return [String] Optional entity scope.
    class CreateSecretRequest
      attr_accessor :name, :value, :entity_id
    end
  end
end
