# frozen_string_literal: true

module FlowHelper
  def request_payment_session_request(**opts)
    amount = opts.fetch(:amount, 1000)
    currency = opts.fetch(:currency, 'USD')
    
    {
      amount: amount,
      currency: currency,
      payment_type: 'Regular',
      billing: {
        address: {
          address_line1: '123 High St.',
          address_line2: 'Flat 456',
          city: 'London',
          state: 'London',
          zip: 'SW1A 1AA',
          country: 'GB'
        },
        phone: {
          country_code: '+1',
          number: '415 555 2671'
        }
      },
      reference: "ORD-#{SecureRandom.uuid[0..8]}",
      description: 'Integration test payment session',
      customer: {
        email: "jia.tsang+#{SecureRandom.uuid[0..5]}@example.com",
        name: 'Jia Tsang',
        phone: {
          country_code: '+1',
          number: '415 555 2671'
        }
      },
      shipping: {
        address: {
          address_line1: '123 High St.',
          address_line2: 'Flat 456',
          city: 'London',
          state: 'London',
          zip: 'SW1A 1AA',
          country: 'GB'
        },
        phone: {
          country_code: '+1',
          number: '415 555 2671'
        }
      },
      processing_channel_id: ENV.fetch('CHECKOUT_PROCESSING_CHANNEL_ID'),
      success_url: 'https://example.com/payments/success',
      failure_url: 'https://example.com/payments/failure',
      enabled_payment_methods: ['card'],
      metadata: {
        test_payment: 'flow_integration_test'
      }
    }
  end

  def submit_payment_session_request(**opts)
    amount = opts.fetch(:amount, 1000)
    
    {
      session_data: 'string',
      amount: amount,
      reference: "SUBMIT-#{SecureRandom.uuid[0..8]}",
      payment_type: 'Regular',
      items: [{
        reference: "item-#{SecureRandom.uuid[0..5]}",
        name: 'Test Item',
        quantity: 1,
        unit_price: amount,
        total_amount: amount
      }],
      ip_address: '90.197.169.245'
    }
  end

  def request_payment_session_with_payment_request(**opts)
    amount = opts.fetch(:amount, 1000)
    currency = opts.fetch(:currency, 'USD')
    
    {
      session_data: 'string',
      amount: amount,
      currency: currency,
      payment_type: 'Regular',
      billing: {
        address: {
          address_line1: '123 High St.',
          address_line2: 'Flat 456',
          city: 'London',
          state: 'London',
          zip: 'SW1A 1AA',
          country: 'GB'
        },
        phone: {
          country_code: '+1',
          number: '415 555 2671'
        }
      },
      reference: "CREATE-SUBMIT-#{SecureRandom.uuid[0..8]}",
      description: 'Integration test create and submit',
      customer: {
        email: "jia.tsang+#{SecureRandom.uuid[0..5]}@example.com",
        name: 'Jia Tsang',
        phone: {
          country_code: '+1',
          number: '415 555 2671'
        }
      },
      processing_channel_id: ENV.fetch('CHECKOUT_PROCESSING_CHANNEL_ID'),
      success_url: 'https://example.com/payments/success',
      failure_url: 'https://example.com/payments/failure'
    }
  end

  def request_payment_session(**opts)
    amount = opts.fetch(:amount, 1000)
    currency = opts.fetch(:currency, 'USD')
    
    request = request_payment_session_request(amount: amount, currency: currency)
    response = default_sdk.flow.request_payment_session(request)
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

  def request_payment_session_with_payment(**opts)
    amount = opts.fetch(:amount, 1000)
    currency = opts.fetch(:currency, 'USD')
    
    request = request_payment_session_with_payment_request(amount: amount, currency: currency)
    response = default_sdk.flow.request_payment_session_with_payment(request)
    expect(response).not_to be nil
    response
  end
end