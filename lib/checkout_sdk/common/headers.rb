# frozen_string_literal: true

module CheckoutSdk
  module Common
    # Optional HTTP headers that callers can pass to a client method, mirroring
    # the SDK's `Headers` pattern. Currently exposes `If-Match` (required
    # by endpoints with optimistic-concurrency semantics, e.g. update reserve
    # rule); future shared headers can be added here.
    #
    # @!attribute if_match
    #   @return [String] ETag value to forward as the `If-Match` HTTP header.
    # @!attribute accept
    #   @return [String] value to forward as the `Accept` HTTP header, e.g.
    #     `application/json;schema_version=3.0` for Accounts API schema negotiation.
    class Headers
      attr_accessor :if_match, :accept
    end
  end
end
