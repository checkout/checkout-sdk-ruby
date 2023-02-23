RSpec.describe CheckoutSdk::Payments::HostedPaymentsClient do
  describe '.create_hosted_payments_page_session' do
    context 'when creating a hosted payment session with valid parameters' do
      it 'creates hosted payments session' do
        request = create_hosted_payments_request
        response = default_sdk.hosted.create_hosted_payments_page_session request

        assert_response response, %w[id
                                     reference
                                     warnings
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
  product.name = 'Gold Necklace'
  product.quantity = 1
  product.price = 10

  three_ds_request = CheckoutSdk::Payments::ThreeDSRequest.new
  three_ds_request.enabled = true
  three_ds_request.attempt_n3d = false

  processing_settings = CheckoutSdk::Payments::ProcessingSettings.new
  processing_settings.aft = true

  risk_request = CheckoutSdk::Payments::RiskRequest.new
  risk_request.enabled = true

  billing_descriptor = CheckoutSdk::Payments::BillingDescriptor.new
  billing_descriptor.city = 'London'
  billing_descriptor.name = 'Awesome name'
  billing_descriptor.reference = 'another reference'

  request = CheckoutSdk::Payments::HostedPaymentsSession.new
  request.amount = 1000
  request.reference = 'reference'
  request.currency = CheckoutSdk::Common::Currency::GBP
  request.description = 'Payment for Gold Necklace'
  request.customer = common_customer_request
  request.shipping = shipping_details
  request.billing = billing_information
  request.recipient = payment_recipient
  request.processing = processing_settings
  request.products = [product]
  request.risk = risk_request
  request.success_url = 'https://example.com/payments/success'
  request.failure_url = 'https://example.com/payments/failure'
  request.cancel_url = 'https://example.com/payments/cancel'
  request.locale = 'en-GB'
  request.three_ds = three_ds_request
  request.capture = true
  request.billing_descriptor = billing_descriptor
  request.allow_payment_methods = [CheckoutSdk::Common::PaymentSourceType::CARD,
                                   CheckoutSdk::Common::PaymentSourceType::IDEAL]

  request
end
