RSpec.describe CheckoutSdk::Payments do

  describe '.request_payments (APMs)' do
    context 'when requesting AfterPay source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::AfterPaySource.new
        source.account_holder = common_account_holder

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 10
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end

    context 'when requesting AliPay source payment' do
      it 'type:CN - raises an error' do
        source = CheckoutSdk::Payments::AlipayPlusSource.alipay_plus_cn_source

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end

    context 'when requesting Bancontact source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::BancontactSource.new
        source.payment_country = CheckoutSdk::Common::Country::BE
        source.account_holder_name = Helpers::DataFactory::NAME
        source.billing_descriptor = 'CKO Demo - bancontact'

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = default_sdk.payments.request_payment(request)
        expect(response).not_to be nil
        expect(response.id).not_to be nil
      end
    end

    context 'when requesting Benefit source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::BenefitSource.new

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::BHD
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    context 'when requesting EPS source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::EPSSource.new
        source.purpose = 'test purpose'

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    context 'when requesting Giropay source payment' do
      skip 'Until it is fixed in Sandbox'
      skip 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::GiropaySource.new

        shipping = CheckoutSdk::Payments::ShippingDetails.new
        shipping.address = address
        shipping.phone = phone

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.description = Helpers::DataFactory::DESCRIPTION
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.shipping = shipping
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    context 'when requesting Ideal source payment', skip: 'unavailable' do
      it 'should request payment correctly' do
        source = CheckoutSdk::Payments::IdealSource.new
        source.description = 'ORD50234E89'
        source.language = 'nl'

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 1000
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = default_sdk.payments.request_payment(request)
        expect(response).not_to be nil
        expect(response.id).not_to be nil

        payment_details = default_sdk.payments.get_payment_details(response.id)
        expect(payment_details).not_to be nil
        expect(payment_details.id).to eq response.id
        expect(payment_details.source.type).to eq CheckoutSdk::Common::PaymentSourceType::IDEAL
      end
    end

    context 'when requesting Knet source payment' do
      it 'raises an error (payee_not_onboarded)' do
        payment_method_details = CheckoutSdk::Payments::PaymentMethodDetails.new
        payment_method_details.display_name = "name"
        payment_method_details.type = "type"
        payment_method_details.network = "card_network"

        source = CheckoutSdk::Payments::KnetSource.new
        source.language = 'en'
        source.payment_method_details = payment_method_details

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::KWD
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = default_sdk.payments.request_payment(request)
        expect(response).not_to be nil
        expect(response.id).not_to be nil
      end
    end

    skip 'Mbway - processing channel invalid' do
      context 'when requesting Mbway source payment' do
        it 'raises an error (apm_service_unavailable)' do
          source = CheckoutSdk::Payments::MbwaySource.new

          request = CheckoutSdk::Payments::PaymentRequest.new
          request.source = source
          request.reference = Helpers::DataFactory::REFERENCE
          request.currency = CheckoutSdk::Common::Currency::GBP
          request.amount = 100
          request.capture = true
          request.success_url = 'https://testing.checkout.com/sucess'
          request.failure_url = 'https://testing.checkout.com/failure'

          expect { default_sdk.payments.request_payment(request) }
            .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
              expect(e.error_details[:error_codes].first).to eq 'apm_service_unavailable' }
        end
      end
    end

    context 'when requesting MultiBanco source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::MultiBancoSource.new
        source.payment_country = CheckoutSdk::Common::Country::PT
        source.account_holder_name = Helpers::DataFactory::NAME
        source.billing_descriptor = 'CKO Demo - MultiBanco'

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    skip 'when requesting P24 source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::P24Source.new
        source.payment_country = CheckoutSdk::Common::Country::PL
        source.account_holder_name = Helpers::DataFactory::NAME
        source.account_holder_email = generate_random_email
        source.billing_descriptor = 'CKO Demo - P24'

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::PLN
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    context 'when requesting PostFinance source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::PostFinanceSource.new
        source.payment_country = CheckoutSdk::Common::Country::CH
        source.account_holder_name = Helpers::DataFactory::NAME
        source.billing_descriptor = 'CKO Demo - PostFinance'

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    context 'when requesting QPay source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::QPaySource.new
        source.description = Helpers::DataFactory::DESCRIPTION
        source.language = 'en'
        source.quantity = 1
        source.national_id = '070AYY010BU234M'

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::QAR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    context 'when requesting Sofort source payment', skip: 'unavailable' do
      it 'should request payment correctly' do
        source = CheckoutSdk::Payments::SofortSource.new

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 1000
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        response = default_sdk.payments.request_payment(request)
        expect(response).not_to be nil
        expect(response.id).not_to be nil

        payment_details = default_sdk.payments.get_payment_details(response.id)
        expect(payment_details).not_to be nil
        expect(payment_details.id).to eq response.id
        expect(payment_details.source.type).to eq CheckoutSdk::Common::PaymentSourceType::SOFORT
      end
    end

    context 'when requesting StcPay source payment' do
      it 'raises an error (apm_service_unavailable)' do
        source = CheckoutSdk::Payments::StcPaySource.new

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::QAR
        request.amount = 100
        request.capture = true
        request.customer = common_customer_request
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end

    context 'when requesting WeChatPay source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::WeChatPaySource.new

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 100
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    context 'when requesting Alma source payment' do
      it 'raises an error (payee_not_onboarded)' do
        source = CheckoutSdk::Payments::AlmaSource.new
        source.billing_address = address

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 10
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    context 'when requesting Klarna source payment', skip: 'unavailable' do
      it 'raises an error (amount_and_item_total_amounts_mismatch)' do
        source = CheckoutSdk::Payments::KlarnaSource.new
        source.account_holder = common_account_holder

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::GBP
        request.amount = 10
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'amount_and_item_total_amounts_mismatch' }
      end
    end

    context 'when requesting Paypal source payment', skip: 'unavailable' do
      it 'raises an error (payee_not_onboarded)' do
        plan = CheckoutSdk::Payments::BillingPlan.new
        plan.type = CheckoutSdk::Payments::BillingPlanType::CHANNEL_INITIATED_BILLING
        plan.immutable_shipping_address = false
        plan.skip_shipping_address = true

        source = CheckoutSdk::Payments::PayPalSource.new
        source.plan = plan

        product = CheckoutSdk::Payments::Product.new
        product.name = 'laptop'
        product.unit_price = 10
        product.quantity = 1

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EUR
        request.amount = 10
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'
        request.items = [product]

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end

    context 'when requesting Fawry source payment' do
      it 'raises an error (payee_not_onboarded)' do
        product = CheckoutSdk::Payments::FawryProduct.new
        product.product_id = '0123456789'
        product.quantity = 1
        product.price = 10
        product.description = 'Fawry Demo Product'

        source = CheckoutSdk::Payments::FawrySource.new
        source.description = 'Fawry Demo Payment'
        source.customer_email = 'bruce@wayne-enterprises.com'
        source.customer_mobile = '01058375055'
        source.products = [product]

        request = CheckoutSdk::Payments::PaymentRequest.new
        request.source = source
        request.reference = Helpers::DataFactory::REFERENCE
        request.currency = CheckoutSdk::Common::Currency::EGP
        request.amount = 10
        request.capture = true
        request.success_url = 'https://testing.checkout.com/sucess'
        request.failure_url = 'https://testing.checkout.com/failure'

        expect { default_sdk.payments.request_payment(request) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
            expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
      end
    end
  end

  context 'when requesting CvConnect source payment' do
    it 'raises an error (payee_not_onboarded)' do
      source = CheckoutSdk::Payments::CvConnectSource.new
      source.billing_address = address

      request = CheckoutSdk::Payments::PaymentRequest.new
      request.source = source
      request.amount = 100
      request.currency = CheckoutSdk::Common::Currency::EUR
      request.capture = true
      request.success_url = Helpers::DataFactory::SUCCESS_URL
      request.failure_url = Helpers::DataFactory::FAILURE_URL

      expect { default_sdk.payments.request_payment(request) }
        .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
          expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
    end
  end

  context 'when requesting Trustly source payment' do
    it 'raises an error (payee_not_onboarded)' do
      source = CheckoutSdk::Payments::TrustlySource.new
      source.billing_address = address

      request = CheckoutSdk::Payments::PaymentRequest.new
      request.source = source
      request.amount = 100
      request.currency = CheckoutSdk::Common::Currency::EUR
      request.capture = true
      request.success_url = Helpers::DataFactory::SUCCESS_URL
      request.failure_url = Helpers::DataFactory::FAILURE_URL

      expect { default_sdk.payments.request_payment(request) }
        .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
          expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
    end
  end

  context 'when requesting Illicado source payment' do
    it 'raises an error (payee_not_onboarded)' do
      source = CheckoutSdk::Payments::IllicadoSource.new
      source.billing_address = address

      request = CheckoutSdk::Payments::PaymentRequest.new
      request.source = source
      request.amount = 100
      request.currency = CheckoutSdk::Common::Currency::EUR
      request.capture = true
      request.success_url = Helpers::DataFactory::SUCCESS_URL
      request.failure_url = Helpers::DataFactory::FAILURE_URL

      expect { default_sdk.payments.request_payment(request) }
        .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
          expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
    end
  end

  context 'when requesting Sepa source payment', skip: 'unavailable' do
    it 'raises an error (apm_service_unavailable)' do
      source = CheckoutSdk::Payments::SepaSource.new
      source.country = CheckoutSdk::Common::Country::ES
      source.account_number = "HU93116000060000000012345676"
      source.bank_code = "37040044"
      source.currency = CheckoutSdk::Common::Currency::EUR
      source.mandate_id = "man_12321233211"
      source.date_of_signature = "2023-01-01"
      source.account_holder = common_account_holder

      request = CheckoutSdk::Payments::PaymentRequest.new
      request.source = source
      request.amount = 100
      request.currency = CheckoutSdk::Common::Currency::EUR
      request.capture = true
      request.success_url = Helpers::DataFactory::SUCCESS_URL
      request.failure_url = Helpers::DataFactory::FAILURE_URL

      expect { default_sdk.payments.request_payment(request) }
        .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
          expect(e.error_details[:error_codes].first).to eq 'apm_service_unavailable' }
    end
  end

  context 'when requesting EPS source payment' do
    it 'raises an error (payee_not_onboarded)' do
      source = CheckoutSdk::Payments::EPSSource.new
      source.purpose = 'Mens black t-shirt L'

      request = CheckoutSdk::Payments::PaymentRequest.new
      request.source = source
      request.amount = 100
      request.currency = CheckoutSdk::Common::Currency::EUR
      request.capture = true
      request.success_url = Helpers::DataFactory::SUCCESS_URL
      request.failure_url = Helpers::DataFactory::FAILURE_URL

      expect { default_sdk.payments.request_payment(request) }
        .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
          expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
    end
  end

  context 'when requesting Bizum source payment' do
    it 'raises an error (apm_service_unavailable)' do
      source = CheckoutSdk::Payments::BizumSource.new
      source.mobile_number = '+447700900986'

      request = CheckoutSdk::Payments::PaymentRequest.new
      request.source = source
      request.amount = 10
      request.currency = CheckoutSdk::Common::Currency::EUR
      request.customer = common_customer_request
      request.capture = true
      request.success_url = Helpers::DataFactory::SUCCESS_URL
      request.failure_url = Helpers::DataFactory::FAILURE_URL

      expect { default_sdk.payments.request_payment(request) }
        .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
          expect(e.error_details[:error_codes].first).to eq 'apm_service_unavailable' }
    end
  end

  context 'when requesting Octopus source payment' do
    it 'raises an error (apm_currency_not_supported)' do
      source = CheckoutSdk::Payments::OctopusSource.new

      request = CheckoutSdk::Payments::PaymentRequest.new
      request.source = source
      request.amount = 10
      request.currency = CheckoutSdk::Common::Currency::USD
      request.capture = true
      request.success_url = Helpers::DataFactory::SUCCESS_URL
      request.failure_url = Helpers::DataFactory::FAILURE_URL

      expect { default_sdk.payments.request_payment(request) }
        .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
          expect(e.error_details[:error_codes].first).to eq 'currency_not_supported' }
    end
  end

  context 'when requesting Plaid source payment', skip: 'unavailable' do
    it 'raises an error (payee_not_onboarded)' do
      source = CheckoutSdk::Payments::PlaidSource.new
      source.token = 'token'
      source.account_holder = common_account_holder

      request = CheckoutSdk::Payments::PaymentRequest.new
      request.source = source
      request.amount = 10
      request.currency = CheckoutSdk::Common::Currency::USD
      request.capture = true
      request.success_url = Helpers::DataFactory::SUCCESS_URL
      request.failure_url = Helpers::DataFactory::FAILURE_URL

      expect { default_sdk.payments.request_payment(request) }
        .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
          expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
    end
  end

  context 'when requesting Sequra source payment' do
    it 'raises an error (payee_not_onboarded)' do
      source = CheckoutSdk::Payments::SequraSource.new
      source.billing_address = address
      request = CheckoutSdk::Payments::PaymentRequest.new
      request.source = source
      request.amount = 10
      request.currency = CheckoutSdk::Common::Currency::EUR
      request.capture = true
      request.success_url = Helpers::DataFactory::SUCCESS_URL
      request.failure_url = Helpers::DataFactory::FAILURE_URL

      expect { default_sdk.payments.request_payment(request) }
        .to raise_error(CheckoutSdk::CheckoutApiException) { |e|
          expect(e.error_details[:error_codes].first).to eq 'payee_not_onboarded' }
    end
  end

end
