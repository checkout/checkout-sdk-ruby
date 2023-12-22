# frozen_string_literal: true

RSpec.describe CheckoutSdk::Payments do
  include ContextsHelper

  before(:all) do
    @payment_context = create_payment_contexts
  end

  describe '.create_payment_contexts' do
    context 'when creating a payment contexts with valid data' do
      it { is_valid_payment_context @payment_context }
    end
  end

  describe '.get_payment_context_details' do
    context 'when retrieving existing payment context details' do
      it { is_valid_payment_context_details default_sdk.contexts.get_payment_context_details @payment_context.id }
    end
  end
end

def is_valid_payment_context(payment_context)
  assert_response payment_context, %w[id
                                      partner_metadata
                                      partner_metadata.order_id]
end

def is_valid_payment_context_details(payment_context_details_response)
  assert_response payment_context_details_response, %w[payment_request
                                                      payment_request.amount
                                                      payment_request.currency
                                                      payment_request.payment_type
                                                      payment_request.capture
                                                      payment_request.items
                                                      payment_request.success_url
                                                      payment_request.failure_url
                                                      partner_metadata
                                                      partner_metadata.order_id]

  expect(payment_context_details_response.payment_request.amount).to eq 2000
  expect(payment_context_details_response.payment_request.currency).to eq CheckoutSdk::Common::Currency::EUR
  expect(payment_context_details_response.payment_request.payment_type).to eq CheckoutSdk::Payments::PaymentType::REGULAR
  expect(payment_context_details_response.payment_request.capture).to eq true
  expect(payment_context_details_response.payment_request.items[0].name).to eq 'mask'
  expect(payment_context_details_response.payment_request.items[0].unit_price).to eq 2000
  expect(payment_context_details_response.payment_request.items[0].quantity).to eq 1
  expect(payment_context_details_response.payment_request.success_url).to eq 'https://example.com/payments/success'
  expect(payment_context_details_response.payment_request.failure_url).to eq 'https://example.com/payments/fail'
  expect(payment_context_details_response.partner_metadata.order_id).not_to be_nil
end
