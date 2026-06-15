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
    class Headers
      attr_accessor :if_match
    end
  end
end
