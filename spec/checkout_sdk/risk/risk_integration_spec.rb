RSpec.describe CheckoutSdk::Risk do

  describe '.pre_authentication_scan' do
    context 'when requesting pre authentication assessment' do
      subject(:source) { card_source }
      it 'should successfully scan card source' do
        request_pre_authentication_scan source
      end

      subject(:source) { customer_source }
      it 'should successfully scan customer source' do
        request_pre_authentication_scan source
      end
    end
  end

  describe '.pre_capture_scan' do
    context 'when requesting pre capture assessment' do
      subject(:source) { card_source }
      it 'should successfully scan card source' do
        request_pre_capture_scan source
      end

      subject(:source) { customer_source }
      it 'should successfully scan customer source' do
        request_pre_authentication_scan source
      end
    end
  end
end

def card_source
  card_source = CheckoutSdk::Risk::CardSource.new
  card_source.billing_address = address
  card_source.number = visa_card.card_number
  card_source.expiry_month = visa_card.expiry_month
  card_source.expiry_year = visa_card.expiry_year
  card_source.phone = phone
  card_source
end

def customer_source
  request = CheckoutSdk::Customers::CustomerRequest.new
  request.email = generate_random_email
  request.name = Helpers::DataFactory::NAME
  request.phone = phone

  response = default_sdk.customers.create(request)

  assert_response response, ['id']

  customer_source = CheckoutSdk::Risk::CustomerSource.new
  customer_source.id = response.id

  customer_source
end

def device
  location = CheckoutSdk::Risk::Location.new
  location.longitude = '0.1313'
  location.latitude = '51.5107'

  device = CheckoutSdk::Risk::Device.new
  device.ip = '90.197.169.245'
  device.location = location
  device.type = 'Phone'
  device.os = 'ISO'
  device.model = 'iPhone X'
  device.date = DateTime.now
  device.user_agent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko)
                       Version/11.0 Mobile/15A372 Safari/604.1'
  device.fingerprint = '34304a9e3fg09302'
  device
end

def risk_payment
  payment = CheckoutSdk::Risk::RiskPayment.new
  payment.psp = 'CheckoutSdk.com'
  payment.id = '78453878'
  payment
end

def shipping_details
  shipping_details = CheckoutSdk::Risk::RiskShippingDetails.new
  shipping_details.address = address
  shipping_details
end

def request_pre_authentication_scan(request_source)
  assessment = CheckoutSdk::Risk::PreAuthenticationAssessment.new
  assessment.date = DateTime.now
  assessment.source = request_source
  assessment.customer = common_customer_request
  assessment.payment = risk_payment
  assessment.shipping = shipping_details
  assessment.reference = 'ORD-1011-87AH'
  assessment.description = 'Set of 3 masks'
  assessment.device = device
  assessment.amount = 6540

  response = default_sdk.risk.pre_authentication_scan(assessment)
  assert_response response, %w[assessment_id
                               result
                               result.decision]
end

def request_pre_capture_scan(request_source)
  authentication_result = CheckoutSdk::Risk::AuthenticationResult.new
  authentication_result.attempted = true
  authentication_result.challenged = true
  authentication_result.liability_shifted = true
  authentication_result.method = '3ds'
  authentication_result.succeeded = true
  authentication_result.version = '2.0'

  authorization_result = CheckoutSdk::Risk::AuthorizationResult.new
  authorization_result.avs_code = 'V'
  authorization_result.cvv_result = 'N'

  assessment = CheckoutSdk::Risk::PreCaptureAssessment.new
  assessment.date = DateTime.now
  assessment.source = request_source
  assessment.customer = common_customer_request
  assessment.payment = risk_payment
  assessment.shipping = shipping_details
  assessment.amount = 6540
  assessment.currency = CheckoutSdk::Common::Currency::GBP
  assessment.device = device
  assessment.authentication_result = authentication_result
  assessment.authorization_result = authorization_result

  response = default_sdk.risk.pre_capture_scan(assessment)
  assert_response response, %w[assessment_id
                               result
                               result.decision]
end


