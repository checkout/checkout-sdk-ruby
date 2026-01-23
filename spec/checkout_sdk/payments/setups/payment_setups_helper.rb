# frozen_string_literal: true

module PaymentSetupsHelper
  def create_payment_setup_request(**opts)
    amount = opts.fetch(:amount, 1000)
    currency = opts.fetch(:currency, 'GBP')
    
    {
      processing_channel_id: ENV.fetch('CHECKOUT_PROCESSING_CHANNEL_ID'),
      amount: amount,
      currency: currency,
      payment_type: 'Regular',
      reference: "TEST-REF-#{SecureRandom.uuid[0..5]}",
      description: 'Integration test payment setup',
      payment_methods: {
        klarna: {
          initialization: 'disabled',
          account_holder: {
            billing_address: {
              address_line1: '123 High Street',
              city: 'London',
              zip: 'SW1A 1AA',
              country: 'GB'
            }
          }
        }
      },
      settings: {
        success_url: 'https://example.com/success',
        failure_url: 'https://example.com/failure'
      },
      customer: {
        name: 'John Smith',
        email: {
          address: "john.smith+#{SecureRandom.uuid[0..5]}@example.com",
          verified: true
        },
        phone: {
          country_code: '+44',
          number: '207 946 0000'
        },
        device: {
          locale: 'en_GB'
        }
      }
    }
  end

  def create_update_payment_setup_request(**opts)
    processing_channel_id = opts.fetch(:processing_channel_id, ENV.fetch('CHECKOUT_PROCESSING_CHANNEL_ID'))
    amount = opts.fetch(:amount, 1000)
    currency = opts.fetch(:currency, 'GBP')
    description = opts.fetch(:description, nil)
    
    request = {
      processing_channel_id: processing_channel_id,
      amount: amount,
      currency: currency,
      payment_type: 'Regular',
      reference: "TEST-REF-#{SecureRandom.uuid[0..5]}",
      payment_methods: {
        klarna: {
          initialization: 'disabled',
          account_holder: {
            billing_address: {
              address_line1: '123 High Street',
              city: 'London',
              zip: 'SW1A 1AA',
              country: 'GB'
            }
          }
        }
      },
      settings: {
        success_url: 'https://example.com/success',
        failure_url: 'https://example.com/failure'
      },
      customer: {
        name: 'John Smith',
        email: {
          address: "john.smith+#{SecureRandom.uuid[0..5]}@example.com",
          verified: true
        },
        phone: {
          country_code: '+44',
          number: '207 946 0000'
        },
        device: {
          locale: 'en_GB'
        }
      }
    }
    request[:description] = description unless description.nil?
    request
  end

  def create_payment_setup(**opts)
    amount = opts.fetch(:amount, 1000)
    currency = opts.fetch(:currency, 'USD')
    
    request = create_payment_setup_request(amount: amount, currency: currency)
    response = default_sdk.payments_setups.create_payment_setup(request)
    expect(response).not_to be nil
    expect(response.id).not_to be nil
    response
  end
end