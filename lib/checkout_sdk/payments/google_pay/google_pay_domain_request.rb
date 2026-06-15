# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # Request body for POST /googlepay/enrollments/{entity_id}/domain.
    #
    # @!attribute web_domain
    #   @return [String] Web domain to register for the enrolled entity.
    class GooglePayDomainRequest
      attr_accessor :web_domain
    end
  end
end
