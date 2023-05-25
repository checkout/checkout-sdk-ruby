# frozen_string_literal: true

RSpec.describe CheckoutSdk::Issuing do
  include IssuingHelper

  skip 'Avoid creating cards all the time' do
    before(:all) do
      @cardholder = create_cardholder
      @card = create_card @cardholder.id, true
    end

    describe '.simulate_authorization' do
      context 'when simulating authorization with valid card' do
        it { authorizes_transaction get_issuing_api.issuing.simulate_authorization get_authorization_request }
      end
    end
  end
end

private

def authorizes_transaction(response)
  assert_response response, %w[id
                               status]

  expect(response.status).to eq 'Authorized'
end

def get_authorization_request
  {
    'card' => {
      'id' => @card.id,
      'expiry_month' => @card.expiry_month,
      'expiry_year' => @card.expiry_year
    },
    'transaction' => {
      'type' => 'purchase',
      'amount' => 100,
      'currency' => CheckoutSdk::Common::Currency::GBP
    }
  }
end
