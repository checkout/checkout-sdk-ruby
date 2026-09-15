RSpec.describe CheckoutSdk::OAuthScopes do
  # The scope constants are the only place their wire values are written down, and no spec
  # requests BALANCES_TOP_UP_INSTRUCTIONS against the sandbox, so a typo would ship silently:
  # an OAuth-configured caller of #retrieve_top_up_instructions would be rejected at the token
  # endpoint with no clue that the SDK sent a scope the authorization server never defined.
  #
  # Values come from components.securitySchemes.OAuth.flows.clientCredentials.scopes in
  # shared/swagger-latest.json.
  describe 'balances scopes' do
    it 'exposes the documented wire values' do
      expect(described_class::BALANCES).to eq 'balances'
      expect(described_class::BALANCES_VIEW).to eq 'balances:view'
      expect(described_class::BALANCES_TOP_UP_INSTRUCTIONS).to eq 'balances:top-up-instructions'
    end
  end

  # Ruby's gap was by far the largest of the six SDKs: 23 of the 70 documented scopes had no
  # constant at all, including whole families the SDK itself implements endpoints for.
  describe 'scopes added in the spec sync' do
    it 'exposes the documented wire values' do
      expect(described_class::AGENTIC_INVENTORY).to eq 'agentic:inventory'
      expect(described_class::CARD_MANAGEMENT).to eq 'card-management'
      expect(described_class::FLOW_REFLOW).to eq 'flow:reflow'
      expect(described_class::GATEWAY_PAYMENT_CANCELLATIONS).to eq 'gateway:payment-cancellations'
      expect(described_class::GATEWAY_PAYMENT_CONTEXTS).to eq 'gateway:payment-contexts'
      expect(described_class::ISSUING_CARD_MANAGEMENT_READ).to eq 'issuing:card-management-read'
      expect(described_class::ISSUING_CARD_MANAGEMENT_WRITE).to eq 'issuing:card-management-write'
      expect(described_class::ISSUING_DISPUTES).to eq 'issuing-disputes'
      expect(described_class::ISSUING_DISPUTES_READ).to eq 'issuing:disputes-read'
      expect(described_class::ISSUING_DISPUTES_WRITE).to eq 'issuing:disputes-write'
      expect(described_class::ISSUING_TRANSACTIONS_READ).to eq 'issuing:transactions-read'
      expect(described_class::ISSUING_TRANSACTIONS_WRITE).to eq 'issuing:transactions-write'
      expect(described_class::PAYMENT_SESSIONS).to eq 'payment-sessions'
      expect(described_class::PAYMENTS_SEARCH).to eq 'payments:search'
      expect(described_class::TRANSACTIONS).to eq 'transactions'
      expect(described_class::VAULT_CUSTOMERS).to eq 'vault:customers'
      expect(described_class::VAULT_NETWORK_TOKENS).to eq 'vault:network-tokens'
      expect(described_class::VAULT_REAL_TIME_ACCOUNT_UPDATER).to eq 'vault:real-time-account-updater'
    end

    # These five are not declared in clientCredentials.scopes at all: they appear only in the
    # per-operation security requirements of GET/POST /compliance-requests/{payment_id}, the
    # /googlepay/enrollments operations and GET /tokens/{tokenId}/metadata. Constants derived from
    # the declared map alone would be missing them.
    it 'exposes the scopes the spec only references from operations' do
      expect(described_class::COMPLIANCE_REQUESTS).to eq 'compliance-requests'
      expect(described_class::COMPLIANCE_REQUESTS_READ).to eq 'compliance-requests:read'
      expect(described_class::COMPLIANCE_REQUESTS_RESPOND).to eq 'compliance-requests:respond'
      expect(described_class::VAULT_GPAYME_ENROLLMENT).to eq 'vault:gpayme-enrollment'
      expect(described_class::VAULT_TOKENS_METADATA).to eq 'vault:tokens-metadata'
    end
  end

  describe 'payment context scopes' do
    # PAYMENT_CONTEXT and GATEWAY_PAYMENT_CONTEXTS read alike but are unrelated scopes, so this
    # pins which is which: the spec requires the former for GET /payment-contexts/{id} and the
    # latter for POST /payment-contexts.
    #
    # 'Payment Context' is the only scope whose value contains a space and a capital letter, which
    # is almost certainly a spec authoring defect -- asserted verbatim because that is the value
    # the authorization server is documented to accept.
    it 'keeps the two scopes distinct' do
      expect(described_class::PAYMENT_CONTEXT).to eq 'Payment Context'
      expect(described_class::GATEWAY_PAYMENT_CONTEXTS).to eq 'gateway:payment-contexts'
    end
  end

  describe 'the constant set as a whole' do
    # A blank value is not caught by the assertions above, which only read the constants they name.
    # OAuthSdkCredentials joins the requested scopes with a space (oauth_sdk_credentials.rb:65), so
    # a blank constant would be sent as an empty entry and the token endpoint would reject the whole
    # request, costing the caller every other scope it asked for.
    it 'gives every constant a non-blank wire value' do
      blank = scopes.reject { |_name, value| value.is_a?(String) && !value.strip.empty? }
      expect(blank).to be_empty
    end

    # Two constants sharing a wire value means one of them is a copy-paste error, and it cannot be
    # caught by the per-scope assertions above, which only ever read the constant they name. The
    # consequence is silent in both directions: a caller selecting the mistyped constant requests a
    # scope it did not ask for, and the scope that constant was supposed to carry is left with no
    # constant at all, so it becomes unreachable through this module.
    it 'does not reuse a wire value across constants' do
      duplicates = scopes.values.tally.select { |_value, count| count > 1 }
      expect(duplicates).to be_empty
    end

    # These five scopes appear nowhere in the specification -- neither in the clientCredentials
    # scope map nor in any operation's security requirement -- so a sweep driven by the spec alone
    # would delete them. They are kept deliberately: the authorization server still grants them and
    # callers still request them. marketplace is the proof: the sandbox payouts client is
    # provisioned for it and answers a request for accounts with {"error":"invalid_scope"}, which is
    # what broke every example in accounts_integration_spec.rb when it was dropped.
    #
    # This example exists to stop the next specification-driven tidy-up from removing them again.
    it 'retains the legacy scopes the specification omits' do
      expect(described_class::ISSUING_CARD_MGMT).to eq 'issuing:card-mgmt'
      expect(described_class::ISSUING_CLIENT).to eq 'issuing:client'
      expect(described_class::MARKETPLACE).to eq 'marketplace'
      expect(described_class::MIDDLEWARE_GATEWAY).to eq 'middleware:gateway'
      expect(described_class::MIDDLEWARE_PAYMENT_CONTEXT).to eq 'middleware:payment-context'
    end

    # Constants are kept alphabetical so the next spec sync produces a readable diff instead of
    # scattering additions through the file, and so the ordering matches the other Checkout SDKs.
    # Underscores are ignored when comparing, which is what puts PAYMENT_CONTEXT, PAYMENT_SESSIONS
    # and PAYMENTS_SEARCH in that order.
    #
    # This reads the source rather than Module#constants on purpose -- see declared_names.
    it 'declares constants in alphabetical order' do
      declared = declared_names.map { |name| name.delete('_').downcase }
      expect(declared).to eq declared.sort
    end

    # Guards the assumption declared_names rests on. If the regexp ever stops matching the file's
    # formatting it would silently scan zero constants, and the ordering example above would pass
    # on an empty array.
    it 'scans the same set of constants out of the source as the module defines' do
      expect(declared_names.map(&:to_sym).sort).to eq described_class.constants.sort
    end
  end

  # Every constant in this module is a scope, so no filtering is needed. Order is not meaningful
  # here -- Module#constants does not return declaration order (see declared_names) -- so only the
  # order-independent examples may use this.
  def scopes
    described_class.constants.to_h { |name| [name, described_class.const_get(name)] }
  end

  # Module#constants cannot be used to check declaration order: it returns this module's constants
  # rotated, starting partway through the list and wrapping around, so the sequence it yields is
  # alphabetical everywhere except one seam and an ordering assertion built on it would fail
  # against a correctly sorted file. Reading the source is the only way to see real declaration
  # order.
  def declared_names
    source = File.read(File.expand_path('../../lib/checkout_sdk/oauth_scopes.rb', __dir__))
    source.scan(/^\s{4}([A-Z][A-Z0-9_]*)\s*=/).flatten
  end
end
