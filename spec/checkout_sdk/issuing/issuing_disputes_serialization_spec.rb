# frozen_string_literal: true

RSpec.describe 'Issuing disputes/cards serialization' do
  describe CheckoutSdk::Issuing::IssuingDisputeFraudType do
    it 'maps every value to its exact swagger string' do
      expected = {
        CARD_LOST: 'card_lost',
        CARD_STOLEN: 'card_stolen',
        CARD_NEVER_RECEIVED: 'card_never_received',
        FRAUDULENT_ACCOUNT: 'fraudulent_account',
        COUNTERFEIT_CARD: 'counterfeit_card',
        ACCOUNT_TAKEOVER: 'account_takeover',
        CARD_NOT_PRESENT_FRAUD: 'card_not_present_fraud',
        MERCHANT_MISREPRESENTATION: 'merchant_misrepresentation',
        CARDHOLDER_MANIPULATION: 'cardholder_manipulation',
        INCORRECT_PROCESSING: 'incorrect_processing',
        OTHER: 'other'
      }
      expected.each do |const, value|
        expect(described_class.const_get(const)).to eq(value)
      end
      expect(described_class.constants.size).to eq(11)
    end
  end

  describe CheckoutSdk::Issuing::IssuingDisputeFraudDetails do
    it 'serializes fraud_type and description' do
      details = described_class.new
      details.fraud_type = CheckoutSdk::Issuing::IssuingDisputeFraudType::CARD_STOLEN
      details.description = 'wallet was stolen'

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(details)

      expect(hash['fraud_type']).to eq('card_stolen')
      expect(hash['description']).to eq('wallet was stolen')
    end
  end

  describe CheckoutSdk::Issuing::CreateDisputeRequest do
    it 'serializes nested fraud_details' do
      details = CheckoutSdk::Issuing::IssuingDisputeFraudDetails.new
      details.fraud_type = CheckoutSdk::Issuing::IssuingDisputeFraudType::COUNTERFEIT_CARD

      req = described_class.new
      req.transaction_id = 'txn_1'
      req.reason = '4808'
      req.fraud_details = details

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(req)

      expect(hash['transaction_id']).to eq('txn_1')
      expect(hash['reason']).to eq('4808')
      expect(hash['fraud_details']['fraud_type']).to eq('counterfeit_card')
    end
  end

  describe CheckoutSdk::Issuing::EscalateDisputeRequest do
    it 'serializes nested fraud_details' do
      details = CheckoutSdk::Issuing::IssuingDisputeFraudDetails.new
      details.fraud_type = CheckoutSdk::Issuing::IssuingDisputeFraudType::ACCOUNT_TAKEOVER

      req = described_class.new
      req.justification = 'reason'
      req.fraud_details = details

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(req)

      expect(hash['justification']).to eq('reason')
      expect(hash['fraud_details']['fraud_type']).to eq('account_takeover')
    end
  end

  describe CheckoutSdk::Issuing::AmendDisputeRequest do
    it 'serializes all six fields incl. action_response' do
      details = CheckoutSdk::Issuing::IssuingDisputeFraudDetails.new
      details.fraud_type = CheckoutSdk::Issuing::IssuingDisputeFraudType::OTHER

      req = described_class.new
      req.reason = '4807'
      req.amount = 1500
      req.evidence = [{ 'evidence_type' => 'proof_of_purchase' }]
      req.fraud_details = details
      req.reason_change_justification = 'updated reason'
      req.action_response = 'answering the requested changes'

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(req)

      expect(hash['reason']).to eq('4807')
      expect(hash['amount']).to eq(1500)
      expect(hash['evidence']).to eq([{ 'evidence_type' => 'proof_of_purchase' }])
      expect(hash['fraud_details']['fraud_type']).to eq('other')
      expect(hash['reason_change_justification']).to eq('updated reason')
      expect(hash['action_response']).to eq('answering the requested changes')
    end
  end

  describe CheckoutSdk::Issuing::SubmitDisputeRequest do
    it 'serializes reason, evidence and amount' do
      req = described_class.new
      req.reason = '4807'
      req.evidence = [{ 'evidence_type' => 'proof_of_purchase' }]
      req.amount = 100

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(req)

      expect(hash['reason']).to eq('4807')
      expect(hash['evidence']).to eq([{ 'evidence_type' => 'proof_of_purchase' }])
      expect(hash['amount']).to eq(100)
    end
  end

  describe CheckoutSdk::Issuing::UpdateCardRequest do
    it 'serializes activation_date and revocation_date' do
      req = described_class.new
      req.activation_date = '2026-06-01T10:00Z'
      req.revocation_date = '2027-03-12'

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(req)

      expect(hash['activation_date']).to eq('2026-06-01T10:00Z')
      expect(hash['revocation_date']).to eq('2027-03-12')
    end
  end
end
