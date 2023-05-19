# frozen_string_literal: true

RSpec.describe CheckoutSdk::Issuing do
  include IssuingHelper

  before(:all) do
    @cardholder = create_cardholder
  end

  describe '.create_cardholder' do
    context 'when creating a cardholder with valid data' do
      it { is_valid_cardholder @cardholder }
    end
  end

  describe '.get_cardholder' do
    context 'when retrieving existing cardholder details' do
      it { is_valid_cardholder get_issuing_api.issuing.get_cardholder @cardholder.id }
    end
  end

  describe '.get_cardholder_cards' do
    context 'when retrieving cardholder cards' do
      it 'should get cards details' do
        cardsResponse = get_issuing_api.issuing.get_cardholder_cards @cardholder.id

        assert_response cardsResponse, %w[cards]

        cardsResponse.cards.each do |card|
          expect(card.cardholder_id).to eq @cardholder.id
          expect(card.client_id).to eq 'cli_p6jeowdtuxku3azxgt2qa7kq7a'
        end
      end
    end
  end
end

def is_valid_cardholder(cardholder)
  assert_response cardholder, %w[id
                                 type
                                 status
                                 reference]

  expect(cardholder.type).to eq 'individual'
  expect(cardholder.reference).to eq 'X-123456-N11'
end
