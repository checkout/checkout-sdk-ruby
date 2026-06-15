RSpec.describe 'Hash <-> typed-DTO request compatibility' do
  # Convention (per .cursor/rules/ruby-endpoint-review.mdc):
  # every client request body / query param accepts EITHER a typed DTO
  # OR a raw Hash. Both must serialize identically through JsonSerializer.
  # This spec locks that rule in for the modules added in this revision.

  def serialize(value)
    CheckoutSdk::JsonSerializer.serialize_by_type(value)
  end

  it 'AgenticCommerce::DelegatedPaymentRequest equals its Hash form' do
    typed = CheckoutSdk::AgenticCommerce::DelegatedPaymentRequest.new
    typed.metadata = { 'order_id' => 'ord_1' }
    hash_form = { 'metadata' => { 'order_id' => 'ord_1' } }
    expect(serialize(typed)).to eq(serialize(hash_form))
  end

  it 'ComplianceRequests::ComplianceResponseRequest equals its Hash form' do
    typed = CheckoutSdk::ComplianceRequests::ComplianceResponseRequest.new
    typed.comments = 'note'
    hash_form = { 'comments' => 'note' }
    expect(serialize(typed)).to eq(serialize(hash_form))
  end

  it 'StandaloneAccountUpdater::AccountUpdaterRequest equals its Hash form' do
    card = CheckoutSdk::StandaloneAccountUpdater::AccountUpdaterCard.new
    card.number = '4242424242424242'
    card.expiry_month = 12
    card.expiry_year = 2030
    src = CheckoutSdk::StandaloneAccountUpdater::AccountUpdaterSourceOptions.new
    src.card = card
    typed = CheckoutSdk::StandaloneAccountUpdater::AccountUpdaterRequest.new
    typed.source_options = src
    hash_form = {
      'source_options' => {
        'card' => { 'number' => '4242424242424242', 'expiry_month' => 12, 'expiry_year' => 2030 }
      }
    }
    expect(serialize(typed)).to eq(serialize(hash_form))
  end

  it 'NetworkTokens::ProvisionNetworkTokenRequest equals its Hash form' do
    source = CheckoutSdk::NetworkTokens::NetworkTokenSourceId.new
    source.id = 'src_xxx'
    typed = CheckoutSdk::NetworkTokens::ProvisionNetworkTokenRequest.new
    typed.source = source
    hash_form = { 'source' => { 'type' => 'id', 'id' => 'src_xxx' } }
    expect(serialize(typed)).to eq(serialize(hash_form))
  end

  it 'NetworkTokens::NetworkTokenCryptogramRequest equals its Hash form' do
    typed = CheckoutSdk::NetworkTokens::NetworkTokenCryptogramRequest.new
    typed.transaction_type = 'ecom'
    hash_form = { 'transaction_type' => 'ecom' }
    expect(serialize(typed)).to eq(serialize(hash_form))
  end

  it 'AmlScreening::AmlVerificationRequest equals its Hash form' do
    sp = CheckoutSdk::Identities::AmlScreening::AmlSearchParameters.new
    sp.configuration_identifier = 'cfg_1'
    typed = CheckoutSdk::Identities::AmlScreening::AmlVerificationRequest.new
    typed.applicant_id = 'aplt_x'
    typed.search_parameters = sp
    typed.monitored = false
    hash_form = {
      'applicant_id' => 'aplt_x',
      'search_parameters' => { 'configuration_identifier' => 'cfg_1' },
      'monitored' => false
    }
    expect(serialize(typed)).to eq(serialize(hash_form))
  end

  it 'IdentityVerification::IdentityVerificationRequest equals its Hash form' do
    declared = CheckoutSdk::Identities::IdentityVerification::IdvDeclaredData.new
    declared.name = 'John Doe'
    typed = CheckoutSdk::Identities::IdentityVerification::IdentityVerificationRequest.new
    typed.applicant_id = 'aplt_x'
    typed.user_journey_id = 'usj_x'
    typed.declared_data = declared
    typed.risk_labels = ['label_1']
    hash_form = {
      'applicant_id' => 'aplt_x',
      'user_journey_id' => 'usj_x',
      'declared_data' => { 'name' => 'John Doe' },
      'risk_labels' => ['label_1']
    }
    expect(serialize(typed)).to eq(serialize(hash_form))
  end

  it 'Issuing::CardholderAccessTokenRequest equals its Hash form' do
    typed = CheckoutSdk::Issuing::CardholderAccessTokenRequest.new
    typed.client_id = 'cid'
    typed.client_secret = 'csec'
    typed.cardholder_id = 'crh_x'
    typed.single_use = true
    hash_form = {
      'grant_type' => 'client_credentials',
      'client_id' => 'cid',
      'client_secret' => 'csec',
      'cardholder_id' => 'crh_x',
      'single_use' => true
    }
    expect(serialize(typed)).to eq(serialize(hash_form))
  end

  it 'Issuing::OobAuthenticationRequest equals its Hash form' do
    td = CheckoutSdk::Issuing::OobSimulateTransactionDetails.new
    td.merchant_name = 'Acme Ltd'
    td.purchase_amount = 100
    td.purchase_currency = 'GBP'
    typed = CheckoutSdk::Issuing::OobAuthenticationRequest.new
    typed.card_id = 'crd_x'
    typed.transaction_details = td
    hash_form = {
      'card_id' => 'crd_x',
      'transaction_details' => {
        'merchant_name' => 'Acme Ltd',
        'purchase_amount' => 100,
        'purchase_currency' => 'GBP'
      }
    }
    expect(serialize(typed)).to eq(serialize(hash_form))
  end

  it 'PaymentMethods::PaymentMethodsQuery equals its Hash form' do
    typed = CheckoutSdk::PaymentMethods::PaymentMethodsQuery.new
    typed.processing_channel_id = 'pc_x'
    hash_form = { 'processing_channel_id' => 'pc_x' }
    expect(serialize(typed)).to eq(serialize(hash_form))
  end
end
