RSpec.describe CheckoutSdk::Payments::PaymentsLinksClient do
  describe '.create_payment_link' do
    context 'when creating a payment link with valid parameters' do
      it 'creates payment link correctly' do
        request = create_payment_links_request
        response = default_sdk.links.create_payment_link request

        assert_response response, %w[id
                                     reference
                                     expires_on
                                     _links
                                     http_metadata]
        expect(response.http_metadata.status_code).to eq 201
      end
    end
  end

  describe '.get_payment_link' do
    subject(:link) { default_sdk.links.create_payment_link create_payment_links_request }
    context 'when fetching an existing payment link' do
      it 'retrieves payment link details' do
        response = default_sdk.links.get_payment_link link.id

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
        expect(response.id).to eq link.id
      end
    end

    context 'when fetching inexistant payment link' do
      it 'raises an error (404 - not_found)' do
        expect { default_sdk.links.get_payment_link 'not_found' }
          .to raise_error(CheckoutSdk::CheckoutApiException)  { |e| expect(e.http_metadata.status_code).to eq 404 }
      end
    end
  end
end

def create_payment_links_request
  billing_information = CheckoutSdk::Payments::BillingInformation.new
  billing_information.address = address
  billing_information.phone = phone

  shipping_details = CheckoutSdk::Payments::ShippingDetails.new
  shipping_details.address = address
  shipping_details.phone = phone

  product = CheckoutSdk::Common::Product.new
  product.name = 'Gold Necklace'
  product.quantity = 1
  product.price = 200

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

  request = CheckoutSdk::Payments::PaymentLink.new
  request.amount = 200
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
  request.return_url = 'https://example.com/payments/return'
  request.locale = 'en-GB'
  request.three_ds = three_ds_request
  request.expires_in = 6400
  request.capture = true
  request.allow_payment_methods = [CheckoutSdk::Common::PaymentSourceType::CARD,
                                   CheckoutSdk::Common::PaymentSourceType::IDEAL]

  request
end

