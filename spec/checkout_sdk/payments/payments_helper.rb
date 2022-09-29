module PaymentsHelper

  def make_card_payment(amount: 10, capture_on: nil, idempotency_key: nil, capture: false)
    identification = get_account_holder_identification

    request = CheckoutSdk::Payments::PaymentRequest.new
    request.source = card_source
    request.reference = SecureRandom.uuid
    request.amount = amount
    request.currency = CheckoutSdk::Common::Currency::USD
    request.capture = capture
    request.customer = common_customer_request
    request.sender = get_individual_sender(identification)

    unless capture_on.nil?
      request.capture = true
      request.capture_on = capture_on
    end

    response = default_sdk.payments.request_payment(request, idempotency_key)
    expect(response).not_to be nil
    expect(response.id).not_to be nil
    response
  end

  def make_token_payment
    token_request = CheckoutSdk::Tokens::CardTokenRequest.new
    token_request.number = visa_card.card_number
    token_request.expiry_month = visa_card.expiry_month
    token_request.expiry_year = visa_card.expiry_year
    token_request.cvv = visa_card.cvv
    token_request.name = visa_card.name
    token_request.billing_address = address
    token_request.phone = phone

    token_response = default_sdk.tokens.request_token(token_request)
    expect(token_response).not_to be nil
    expect(token_response.token).not_to be nil

    source = CheckoutSdk::Payments::TokenSource.new
    source.token = token_response.token

    request = CheckoutSdk::Payments::PaymentRequest.new
    request.source = source
    request.capture = true
    request.reference = SecureRandom.uuid
    request.amount = 10
    request.currency = CheckoutSdk::Common::Currency::USD
    request.customer = common_customer_request
    request.sender = CheckoutSdk::Payments::InstrumentSender.new

    response = default_sdk.payments.request_payment(request)
    expect(response).not_to be nil
    expect(response.id).not_to be nil
    response
  end

  def make_3ds_card_payment(attempt_n3d: false)
    three_ds_request = CheckoutSdk::Payments::ThreeDSRequest.new
    three_ds_request.enabled = true
    three_ds_request.attempt_n3d = attempt_n3d
    three_ds_request.eci = attempt_n3d ? '05' : ''
    three_ds_request.cryptogram = attempt_n3d ? 'AgAAAAAAAIR8CQrXcIhbQAAAAAA' : ''
    three_ds_request.xid = attempt_n3d ? 'MDAwMDAwMDAwMDAwMDAwMzIyNzY' : ''
    three_ds_request.version = '2.0.1'

    sender = CheckoutSdk::Payments::CorporateSender.new
    sender.company_name = 'Testing Inc'
    sender.address = address

    request = CheckoutSdk::Payments::PaymentRequest.new
    request.source = card_source
    request.capture = true
    request.reference = SecureRandom.uuid
    request.amount = 10
    request.currency = CheckoutSdk::Common::Currency::GBP
    request.customer = common_customer_request
    request.three_ds = three_ds_request
    request.sender = sender
    request.success_url = Helpers::DataFactory::SUCCESS_URL
    request.failure_url = Helpers::DataFactory::FAILURE_URL

    response = default_sdk.payments.request_payment(request)
    expect(response).not_to be nil
    expect(response.id).not_to be nil
    response
  end

  def card_source
    source = CheckoutSdk::Payments::CardSource.new
    source.number = visa_card.card_number
    source.expiry_month = visa_card.expiry_month
    source.expiry_year = visa_card.expiry_year
    source.cvv = visa_card.cvv
    source.name = visa_card.name
    source.billing_address = address
    source.phone = phone
    source
  end

  def get_individual_sender(identification)
    sender = CheckoutSdk::Payments::IndividualSender.new
    sender.first_name = Helpers::DataFactory::FIRST_NAME
    sender.first_name = Helpers::DataFactory::LAST_NAME
    sender.address = address
    sender.identification = identification
    sender
  end

  def get_account_holder_identification
    identification = CheckoutSdk::Common::AccountHolderIdentification.new
    identification.type = CheckoutSdk::Common::AccountHolderIdentificationType::DRIVING_LICENSE
    identification.number = '1234'
    identification.issuing_country = CheckoutSdk::Common::Country::GB
    identification
  end

  def get_amount_allocations(id: nil, amount: 10, reference: Helpers::DataFactory::REFERENCE, commission: nil)
    amount_allocations = CheckoutSdk::Common::AmountAllocations.new
    amount_allocations.id = id
    amount_allocations.amount = amount
    amount_allocations.reference = reference
    amount_allocations.commission = commission
    amount_allocations
  end

end
