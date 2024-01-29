# frozen_string_literal: true

RSpec.describe CheckoutSdk::Payments do
  include PaymentSessionsHelper

  before(:all) do
    @payment_sessions = create_payment_sessions
  end

  describe '.create_payment_sessions' do
    context 'when creating a payment sessions with valid data' do
      it { is_valid_payment_sessions @payment_sessions }
    end
  end
end

def is_valid_payment_sessions(payment_sessions)
  assert_response payment_sessions, %w[id
                                    amount
                                    locale
                                    currency
                                    payment_methods
                                    _links
                                    _links.self]

  expect(payment_sessions.id).not_to be nil
  expect(payment_sessions.amount).to eq 2000
  expect(payment_sessions.locale).to eq 'en-GB'
  expect(payment_sessions.currency).to eq CheckoutSdk::Common::Currency::GBP
  expect(payment_sessions.payment_methods).not_to be nil
end
