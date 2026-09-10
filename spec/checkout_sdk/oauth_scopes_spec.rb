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
end
