# frozen_string_literal: true

module CheckoutSdk
  module NetworkTokens
    # Existing-instrument source for provisioning a network token. Set `type = "id"`.
    #
    # @!attribute type
    #   @return [String] Always "id".
    # @!attribute id
    #   @return [String] The source instrument id (e.g. "src_...").
    class NetworkTokenSourceId
      attr_accessor :type, :id

      def initialize
        @type = 'id'
      end
    end
  end
end
