# frozen_string_literal: true

module Helpers
  # Every client the suite builds has to choose a domain now that the merchant-specific subdomain
  # is mandatory, so they all come through here.
  #
  # The suite uses the shared hosts. It would be better to exercise the merchant-specific
  # subdomain, since that is the path merchants are being moved to, but the sandbox OAuth clients
  # are not provisioned for it: pointing the token request at
  # {subdomain}.access.sandbox.checkout.com returns invalid_client for every integration spec.
  # Until those clients are bound to the subdomain, CI has to use the legacy hosts.
  module DomainConfiguration
    def self.configure(builder)
      original = Warning[:deprecated]
      Warning[:deprecated] = false
      builder.with_legacy_domain
    ensure
      Warning[:deprecated] = original
    end
  end
end
