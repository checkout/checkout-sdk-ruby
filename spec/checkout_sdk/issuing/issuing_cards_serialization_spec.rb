# frozen_string_literal: true

# The card scheduling fields aligned with the 2026-09-02 swagger delta. These used to live in
# issuing_disputes_serialization_spec.rb, which had nothing to do with cards.
RSpec.describe 'Issuing cards serialization' do
  def serialize(request)
    CheckoutSdk::JsonSerializer.to_custom_hash(request)
  end

  describe CheckoutSdk::Issuing::UpdateCardRequest do
    it 'serializes scheduled_activation_date and revocation_date' do
      req = described_class.new
      req.scheduled_activation_date = '2026-06-01T10:00Z'
      req.revocation_date = '2027-03-12'

      hash = serialize(req)

      expect(hash['scheduled_activation_date']).to eq('2026-06-01T10:00Z')
      expect(hash['revocation_date']).to eq('2027-03-12')
      expect(hash).not_to have_key('activation_date')
    end

    it 'no longer declares activation_date' do
      # Ruby attr_accessor is defined per class, so a caller still calling
      # req.activation_date = ... raises NoMethodError rather than silently serializing a key the
      # API rejects. That is a better failure mode than php or python, where the assignment would
      # succeed, and this guard records it.
      expect(described_class.new).not_to respond_to(:activation_date)
      expect(described_class.new).not_to respond_to(:activation_date=)
      expect(described_class.new).to respond_to(:scheduled_activation_date=)
    end

    it 'serializes every declared attribute' do
      req = described_class.new
      req.reference = 'X-123456-N11'
      req.metadata = { 'udf1' => 'metadata1' }
      req.expiry_month = 6
      req.expiry_year = 2030
      req.scheduled_activation_date = '2026-06-01T10:00Z'
      req.revocation_date = '2027-03-12'

      expect(serialize(req)).to eq(
        'reference' => 'X-123456-N11',
        'metadata' => { 'udf1' => 'metadata1' },
        'expiry_month' => 6,
        'expiry_year' => 2030,
        'scheduled_activation_date' => '2026-06-01T10:00Z',
        'revocation_date' => '2027-03-12'
      )
    end

    it 'omits unset attributes' do
      expect(serialize(described_class.new)).to eq({})
    end

    # The swagger example for update-card-request, verbatim.
    it 'round trips the swagger example' do
      payload = JSON.parse(
        '{"reference":"X-123456-N11","expiry_month":6,"expiry_year":2030,' \
        '"revocation_date":"2027-03-12","scheduled_activation_date":"2026-06-01T10:00Z"}'
      )

      req = described_class.new
      req.reference = payload['reference']
      req.expiry_month = payload['expiry_month']
      req.expiry_year = payload['expiry_year']
      req.revocation_date = payload['revocation_date']
      req.scheduled_activation_date = payload['scheduled_activation_date']

      expect(serialize(req)).to eq(payload)
    end
  end

  describe CheckoutSdk::Issuing::CardUpdateHeaders do
    it 'exposes the two headers the endpoint accepts' do
      headers = described_class.new
      expect(headers).to respond_to(:return_encrypted_cvv=)
      expect(headers).to respond_to(:encryption_key=)
    end

    it 'declares return_encrypted_cvv as a string value, not a boolean' do
      headers = described_class.new
      headers.return_encrypted_cvv = 'true'
      expect(headers.return_encrypted_cvv).to eq('true')
    end
  end
end
