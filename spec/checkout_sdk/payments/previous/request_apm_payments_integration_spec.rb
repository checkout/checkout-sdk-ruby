RSpec.describe CheckoutSdk::Previous::Payments do
  include Previous::PaymentsHelper

  describe '.request_payments (APMs)' do
    context 'when requesting Alipay source payment' do
      it 'requests payment correctly' do
        source = CheckoutSdk::Previous::Payments::AlipaySource.new

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.currency = CheckoutSdk::Common::Currency::USD
        request.amount = 100

        response = previous_sdk.payments.request_payment(request)

        assert_response response, %w[id
                                     status
                                     customer
                                     _links]
      end
    end

    context 'when requesting Bancontact source payment' do
      it 'requests payment correctly' do
        source = CheckoutSdk::Previous::Payments::BancontactSource.new
        source.payment_country = CheckoutSdk::Common::Country::BE
        source.account_holder_name = Helpers::DataFactory::NAME
        source.billing_descriptor = 'CKO Demo - bancontact'

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)

        assert_response response, %w[id
                                     status
                                     reference
                                     customer
                                     _links]
      end
    end

    context 'when requesting BenefitPay source payment' do
      it 'requests payment correctly' do
        source = CheckoutSdk::Previous::Payments::BenefitPaySource.new
        source.integration_type = 'mobile'

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::BHD
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)

        assert_response response, %w[id
                                     status
                                     reference
                                     customer
                                     _links]
      end
    end

    context 'when requesting Boleto source payment' do
      it 'raises an error (payment_method_not_supported)' do
        source = CheckoutSdk::Previous::Payments::BoletoSource.new
        source.country = CheckoutSdk::Common::Country::BR
        source.description = 'boleto payment'
        source.payer = payer
        source.integration_type = CheckoutSdk::Previous::Payments::IntegrationType::DIRECT

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { previous_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.error_details[:error_codes].first).to eq 'payment_method_not_supported' }
      end
    end

    context 'when requesting EPS source payment' do
      it 'requests payment correctly' do
        source = CheckoutSdk::Previous::Payments::EPSSource.new
        source.purpose = 'test purpose'

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)

        assert_response response, %w[id
                                     status
                                     reference
                                     customer
                                     _links]
      end
    end

    context 'when requesting Fawry source payment' do
      it 'requests payment correctly' do
        product = CheckoutSdk::Previous::Payments::FawryProduct.new
        product.product_id = '0123456789'
        product.quantity = 1
        product.price = 10
        product.description = 'Fawry Demo Product'

        source = CheckoutSdk::Previous::Payments::FawrySource.new
        source.description = 'Fawry Demo Payment'
        source.customer_email = 'bruce@wayne-enterprises.com'
        source.customer_mobile = '01058375055'
        source.products = [product]

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EGP
        request.amount = 10
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)

        assert_response response, %w[id
                                     status
                                     reference
                                     customer
                                     _links]
      end
    end

    context 'when requesting Giropay source payment' do
      it 'requests payment correctly' do
        source = CheckoutSdk::Previous::Payments::GiropaySource.new
        source.purpose = 'test purpose'

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)

        assert_response response, %w[id
                                     status
                                     reference
                                     customer
                                     _links]
      end
    end

    context 'when requesting Ideal source payment' do
      it 'should request payment correctly' do
        source = CheckoutSdk::Previous::Payments::IdealSource.new
        source.bic = 'INGBNL2A'
        source.description = 'ORD50234E89'
        source.language = 'nl'

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 1000
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)
        assert_response response, %w[id]

        payment_details = previous_sdk.payments.get_payment_details(response.id)
        assert_response response
        expect(payment_details.id).to eq response.id
        expect(payment_details.source.type).to eq CheckoutSdk::Common::PaymentSourceType::IDEAL
      end
    end

    context 'when requesting Knet source payment' do
      it 'requests payment correctly' do
        source = CheckoutSdk::Previous::Payments::KnetSource.new
        source.language = 'en'

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::KWD
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)

        assert_response response, %w[id
                                     status
                                     reference
                                     customer
                                     _links]
      end
    end

    context 'when requesting MultiBanco source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Previous::Payments::MultiBancoSource.new
        source.payment_country = CheckoutSdk::Common::Country::PT
        source.account_holder_name = Helpers::DataFactory::NAME
        source.billing_descriptor = 'CKO Demo - MultiBanco'

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    context 'when requesting Oxxo source payment' do
      it 'raises an error (business_not_onboarded)' do
        source = CheckoutSdk::Previous::Payments::OxxoSource.new
        source.integration_type = CheckoutSdk::Previous::Payments::IntegrationType::DIRECT
        source.country = CheckoutSdk::Common::Country::MX
        source.description = Helpers::DataFactory::DESCRIPTION
        source.payer = payer

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::MXN
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { previous_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.error_details[:error_codes].first).to eq 'business_not_onboarded' }
      end
    end

    context 'when requesting P24 source payment' do
      it 'requests payment correctly' do
        source = CheckoutSdk::Previous::Payments::P24Source.new
        source.payment_country = CheckoutSdk::Common::Country::PL
        source.account_holder_name = Helpers::DataFactory::NAME
        source.account_holder_email = generate_random_email
        source.billing_descriptor = 'CKO Demo - P24'

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::PLN
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)

        assert_response response, %w[id
                                     status
                                     reference
                                     customer
                                     _links]
      end
    end

    context 'when requesting PagoFacil source payment' do
      it 'raises an error (business_not_onboarded)' do
        source = CheckoutSdk::Previous::Payments::PagoFacilSource.new
        source.integration_type = CheckoutSdk::Previous::Payments::IntegrationType::REDIRECT
        source.country = CheckoutSdk::Common::Country::AR
        source.description = Helpers::DataFactory::DESCRIPTION
        source.payer = payer

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::ARS
        request.amount = 1000
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { previous_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.error_details[:error_codes].first).to eq 'business_not_onboarded' }
      end
    end

    context 'when requesting Poli source payment' do
      it 'requests payment correctly' do
        source = CheckoutSdk::Previous::Payments::PoliSource.new

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::AUD
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)

        assert_response response, %w[id
                                     action_id
                                     amount
                                     currency
                                     approved
                                     status
                                     reference
                                     _links]
      end
    end

    context 'when requesting QPay source payment' do
      it 'requests payment correctly' do
        source = CheckoutSdk::Previous::Payments::QPaySource.new
        source.description = Helpers::DataFactory::DESCRIPTION
        source.language = 'en'
        source.quantity = 1
        source.national_id = '070AYY010BU234M'

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::QAR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)

        assert_response response, %w[id
                                     status
                                     reference
                                     customer
                                     _links]
      end
    end

    context 'when requesting RapiPago source payment' do
      it 'raises an error (business_not_onboarded)' do
        source = CheckoutSdk::Previous::Payments::RapiPagoSource.new
        source.integration_type = CheckoutSdk::Previous::Payments::IntegrationType::REDIRECT
        source.country = CheckoutSdk::Common::Country::AR
        source.description = Helpers::DataFactory::DESCRIPTION
        source.payer = payer

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::ARS
        request.amount = 1000
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { previous_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.error_details[:error_codes].first).to eq 'business_not_onboarded' }
      end
    end

    context 'when requesting Sofort source payment' do
      it 'should request payment correctly' do
        source = CheckoutSdk::Previous::Payments::SofortSource.new

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 1000
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = previous_sdk.payments.request_payment(request)
        assert_response response, %w[id]

        payment_details = previous_sdk.payments.get_payment_details(response.id)
        assert_response response
        expect(payment_details.id).to eq response.id
        expect(payment_details.source.type).to eq CheckoutSdk::Common::PaymentSourceType::SOFORT
      end
    end

    context 'when requesting Alma source payment' do
      it 'raises an error (payment_method_not_supported)' do
        source = CheckoutSdk::Previous::Payments::AlmaSource.new
        source.billing_address = address

        request = CheckoutSdk::Previous::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 10
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { previous_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.error_details[:error_codes].first).to eq 'payment_method_not_supported' }
      end
    end
  end
end

