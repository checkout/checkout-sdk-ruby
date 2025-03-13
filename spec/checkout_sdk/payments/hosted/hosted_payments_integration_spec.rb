RSpec.describe CheckoutSdk::Payments::HostedPaymentsClient do
  describe '.create_hosted_payments_page_session' do
    context 'when creating a hosted payment session with valid parameters' do
      it 'creates hosted payments session' do
        request = create_hosted_payments_request
        response = default_sdk.hosted.create_hosted_payments_page_session request

        assert_response response, %w[id
                                     reference
                                     _links
                                     http_metadata]
        expect(response.http_metadata.status_code).to eq 201
      end
    end
  end

  describe '.get_hosted_payments_page_details' do
    subject(:session) { default_sdk.hosted.create_hosted_payments_page_session create_hosted_payments_request }
    context 'when fetching an existing hosted payment session' do
      it 'retrieves hosted payments session details' do
        response = default_sdk.hosted.get_hosted_payments_page_details session.id

        assert_response response, %w[id
                                     status
                                     amount
                                     currency
                                     reference
                                     description
                                     customer
                                     billing
                                     products
                                     _links
                                     http_metadata]
        expect(response.http_metadata.status_code).to eq 200
        expect(response.id).to eq session.id
      end
    end

    context 'when fetching inexistant hosted payment session' do
      it 'raises an error (404 - not_found)' do
        expect { default_sdk.hosted.get_hosted_payments_page_details 'not_found' }
          .to raise_error(CheckoutSdk::CheckoutApiException)  { |e| expect(e.http_metadata.status_code).to eq 404 }
      end
    end
  end
end

def create_hosted_payments_request
  billing_information = CheckoutSdk::Payments::BillingInformation.new
  billing_information.address = address
  billing_information.phone = phone

  shipping_details = CheckoutSdk::Payments::ShippingDetails.new
  shipping_details.address = address
  shipping_details.phone = phone

  product = CheckoutSdk::Common::Product.new
  product.reference = "string"
  product.name = "Gold Necklace"
  product.quantity = 1
  product.price = 1000

  three_ds_request = CheckoutSdk::Payments::ThreeDSRequest.new
  three_ds_request.enabled = false
  three_ds_request.attempt_n3d = false
  three_ds_request.challenge_indicator = CheckoutSdk::Payments::ChallengeIndicator::NO_PREFERENCE
  three_ds_request.allow_upgrade = true
  three_ds_request.exemption = CheckoutSdk::Payments::Exemption::LOW_VALUE

  processing_settings = CheckoutSdk::Payments::ProcessingSettings.new
  processing_settings.aft = true

  risk_request = CheckoutSdk::Payments::RiskRequest.new
  risk_request.enabled = false

  billing_descriptor = CheckoutSdk::Payments::BillingDescriptor.new
  billing_descriptor.city = "London"
  billing_descriptor.name = "The Jewelry Shop"
  billing_descriptor.reference = "ORD-123A"

  customer_retry = CheckoutSdk::Payments::PaymentRetryRequest.new
  customer_retry.max_attempts = 2

  sender = CheckoutSdk::Payments::InstrumentSender.new
  sender.reference = "8285282045818"

  recipient = CheckoutSdk::Payments::PaymentRecipient.new
  recipient.date_of_birth = "1985-05-15"
  recipient.account_number = "5555554444"
  recipient.address = address
  recipient.zip = "SW1A"
  recipient.first_name = "John"
  recipient.last_name = "Jones"

  instruction = CheckoutSdk::Payments::PaymentInstruction.new
  instruction.purpose = CheckoutSdk::Payments::PaymentPurposeType::DONATIONS

  payment_method_configuration = CheckoutSdk::Payments::PaymentMethodConfiguration.new

  applepay = CheckoutSdk::Payments::Applepay.new
  applepay.account_holder = CheckoutSdk::Payments::AccountHolder.new
  applepay.account_holder.first_name = "John"
  applepay.account_holder.last_name = "Jones"
  applepay.account_holder.type = CheckoutSdk::Payments::AccountHolderType::INDIVIDUAL

  card = CheckoutSdk::Payments::Card.new
  card.account_holder = CheckoutSdk::Payments::AccountHolder.new
  card.account_holder.first_name = "John"
  card.account_holder.last_name = "Jones"
  card.account_holder.type = CheckoutSdk::Payments::AccountHolderType::INDIVIDUAL

  googlepay = CheckoutSdk::Payments::Googlepay.new
  googlepay.account_holder = CheckoutSdk::Payments::AccountHolder.new
  googlepay.account_holder.first_name = "John"
  googlepay.account_holder.last_name = "Jones"
  googlepay.account_holder.type = CheckoutSdk::Payments::AccountHolderType::INDIVIDUAL

  payment_method_configuration.applepay = applepay
  payment_method_configuration.card = card
  payment_method_configuration.googlepay = googlepay

  amount_allocations = CheckoutSdk::Payments::AmountAllocations.new
  amount_allocations.id = "ent_w4jelhppmfiufdnatam37wrfc4"
  amount_allocations.amount = 1000
  amount_allocations.reference = "ORD-5023-4E89"

  commission = CheckoutSdk::Payments::Commission.new
  commission.amount = 1000
  commission.percentage = 1.125
  amount_allocations.commission = commission

  request = CheckoutSdk::Payments::HostedPaymentsSession.new
  request.amount = 1000
  request.reference = "reference"
  request.currency = CheckoutSdk::Common::Currency::GBP
  request.description = "Payment for Gold Necklace"
  request.display_name = "The Jewelry Shop"
  request.customer = common_customer_request
  request.shipping = shipping_details
  request.billing = billing_information
  request.recipient = recipient
  request.processing = processing_settings
  request.products = [product]
  request.risk = risk_request
  request.success_url = "https://example.com/payments/success"
  request.failure_url = "https://example.com/payments/failure"
  request.cancel_url = "https://example.com/payments/cancel"
  request.locale = CheckoutSdk::Payments::LocaleType::AR
  request.three_ds = three_ds_request
  request.capture = true
  request.billing_descriptor = billing_descriptor
  request.customer_retry = customer_retry
  request.sender = sender
  request.instruction = instruction
  request.payment_method_configuration = payment_method_configuration
  request.amount_allocations = [amount_allocations]

  request.allow_payment_methods = [
    CheckoutSdk::Common::PaymentSourceType::CARD,
    CheckoutSdk::Common::PaymentSourceType::GOOGLEPAY,
    CheckoutSdk::Common::PaymentSourceType::APPLEPAY
  ]

  request.disabled_payment_methods = [
    CheckoutSdk::Common::PaymentSourceType::EPS,
    CheckoutSdk::Common::PaymentSourceType::IDEAL,
    CheckoutSdk::Common::PaymentSourceType::KNET
  ]

  request.processing_channel_id = ENV["CHECKOUT_PROCESSING_CHANNEL_ID"]

  request
end
