# frozen_string_literal: true

RSpec.describe CheckoutSdk::Issuing do
  include IssuingHelper

  skip 'Avoid creating cards all the time' do
    before(:all) do
      @cardholder = create_cardholder
      @card = create_card @cardholder.id, true
      @transaction = simulate_transaction @card
    end

    describe '.simulate_authorization' do
      context 'when simulating authorization with valid card' do
        it { authorizes_transaction get_issuing_api.issuing.simulate_authorization get_authorization_request }
      end
    end

    describe '.simulate_increment' do
      context 'when simulating increment authorization with valid card' do
        it { authorizes_transaction get_issuing_api.issuing.simulate_increment @transaction.id, { 'amount' => 300 } }
      end
    end

    describe '.simulate_clearing' do
      context 'when simulating a clearing of an existing transaction' do
        it { authorizes_clearing get_issuing_api.issuing.simulate_clearing @transaction.id, { 'amount' => 100 } }
      end
    end

    describe '.simulate_reversal' do
      context 'when simulating a reversal of an existing transaction' do
        it { reverses_transaction get_issuing_api.issuing.simulate_reversal @transaction.id, { 'amount' => 100 } }
      end
    end
  end
end

private

def authorizes_transaction(response)
  assert_response response, %w[status]

  expect(response.status).to eq 'Authorized'
end

def authorizes_clearing(response)
  assert_response response

  expect(response.http_metadata.status_code).to eq 202
end

def reverses_transaction(response)
  assert_response response, %w[status]

  expect(response.status).to eq 'Reversed'
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
