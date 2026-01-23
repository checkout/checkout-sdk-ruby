# frozen_string_literal: true

module FlowHelper
  def create_payment_session_request(**opts)
    amount = opts.fetch(:amount, 1000)
    currency = opts.fetch(:currency, 'GBP')
    
    {
      processing_channel_id: ENV.fetch('CHECKOUT_PROCESSING_CHANNEL_ID'),
      amount: amount,
      currency: currency,
      reference: "FLOW-TEST-#{SecureRandom.uuid[0..5]}",
      description: 'Integration test payment session',
      customer: {
        name: 'John Doe',
        email: {
          address: "john.doe+#{SecureRandom.uuid[0..5]}@example.com",
          verified: true
        },
        phone: {
          country_code: '+44',
          number: '207 946 0000'
        }
      },
      billing: {
        address: {
          address_line1: '123 High Street',
          city: 'London',
          zip: 'SW1A 1AA',
          country: 'GB'
        }
      },
      success_url: 'https://example.com/success',
      failure_url: 'https://example.com/failure'
    }
  end

  def submit_payment_session_request(**opts)
    payment_method_type = opts.fetch(:payment_method_type, 'card')
    
    case payment_method_type
    when 'card'
      {
        payment_method: {
          type: 'card',
          number: '4242424242424242',
          expiry_month: 12,
          expiry_year: 2025,
          cvv: '100',
          name: 'John Doe'
        }
      }
    else
      {
        payment_method: {
          type: payment_method_type
        }
      }
    end
  end

  def create_and_submit_payment_session_request(**opts)
    session_request = create_payment_session_request(**opts)
    submit_request = submit_payment_session_request(**opts)
    
    session_request.merge(submit_request)
  end

  def create_payment_session(**opts)
    amount = opts.fetch(:amount, 1000)
    currency = opts.fetch(:currency, 'USD')
    
    request = create_payment_session_request(amount: amount, currency: currency)
    response = default_sdk.flow.create_payment_session(request)
    expect(response).not_to be nil
    expect(response.id).not_to be nil
    response
  end

  def submit_payment_session(session_id, **opts)
    request = submit_payment_session_request(**opts)
    response = default_sdk.flow.submit_payment_session(session_id, request)
    expect(response).not_to be nil
    response
  end

  def create_and_submit_payment_session(**opts)
    amount = opts.fetch(:amount, 1000)
    currency = opts.fetch(:currency, 'USD')
    
    request = create_and_submit_payment_session_request(amount: amount, currency: currency)
    response = default_sdk.flow.create_and_submit_payment_session(request)
    expect(response).not_to be nil
    response
  end
end