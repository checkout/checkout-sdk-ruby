# frozen_string_literal: true

module Helpers
  # Every client the suite builds has to choose a domain now that the merchant-specific subdomain
  # is mandatory, so they all come through here. There are deliberately two modes.
  #
  # Default: the shared hosts. The sandbox OAuth clients are not provisioned for the
  # merchant-specific subdomain, so pointing the token request at
  # {subdomain}.access.sandbox.checkout.com returns invalid_client for every integration spec.
  #
  # Opt-in: set CHECKOUT_TEST_USE_SUBDOMAIN=true and the suite runs against
  # CHECKOUT_MERCHANT_SUBDOMAIN instead, exercising end to end the path merchants are being moved
  # to. Once sandbox is provisioned like production, set that variable in the workflows and this
  # becomes the mode CI runs in. The switch is deliberately separate from
  # CHECKOUT_MERCHANT_SUBDOMAIN, which CI already exports, so provisioning drives the change
  # rather than the presence of a secret.
  module DomainConfiguration
    def self.use_subdomain?
      ENV.fetch('CHECKOUT_TEST_USE_SUBDOMAIN', '').downcase == 'true'
    end

    def self.configure(builder)
      subdomain = ENV.fetch('CHECKOUT_MERCHANT_SUBDOMAIN', nil)
      return builder.with_environment_subdomain(subdomain) if use_subdomain? && !subdomain.to_s.strip.empty?

      original = Warning[:deprecated]
      Warning[:deprecated] = false
      builder.with_legacy_domain
    ensure
      Warning[:deprecated] = original unless original.nil?
    end
  end
end
