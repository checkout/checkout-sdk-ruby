RSpec.describe CheckoutSdk::Previous::Apm::KlarnaClient do
  describe '.create_credit_session' do
    context 'when creating session with valid parameters' do
      it 'creates credit session correctly', skip: 'unavailable' do
        response = previous_sdk.klarna.create_credit_session get_credit_session_request

        expect(response).not_to be nil
        expect(response.session_id).not_to be nil
        expect(response.client_token).not_to be nil
        expect(response.payment_method_categories).not_to be nil
      end
    end

    context 'when creating session with invalid parameters' do
      it 'raises an error', skip: 'unavailable' do
        request = CheckoutSdk::Previous::Apm::CreditSessionRequest.new

        expect { previous_sdk.klarna.create_credit_session request }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.error_details[:error_type]).to eq 'request_invalid' }
      end
    end
  end

  describe '.get_credit_session' do
    context 'when fetching existing credit session' do
      before(:example) {
        @session = previous_sdk.klarna.create_credit_session get_credit_session_request
      }
      it 'retrieves credit session details', skip: 'unavailable' do
        response = previous_sdk.klarna.get_credit_session @session.session_id

        expect(response).not_to be nil
        expect(response.client_token).to eq @session.client_token
        expect(response.purchase_country).to eq CheckoutSdk::Common::Country::GB.downcase
        expect(response.currency).to eq CheckoutSdk::Common::Currency::GBP.downcase
        expect(response.amount).to eq 1000
        expect(response.tax_amount).to eq 1
      end
    end

    context 'when fetching inexistant credit session' do
      it 'raises an error', skip: 'unavailable' do
        expect { previous_sdk.klarna.get_credit_session 'not_found' }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.http_metadata.status_code).to eq 404 }
      end
    end
  end
end

private def get_credit_session_request
  request = CheckoutSdk::Previous::Apm::CreditSessionRequest.new
  request.purchase_country = CheckoutSdk::Common::Country::GB
  request.currency = CheckoutSdk::Common::Currency::GBP
  request.locale = 'en-GB'
  request.amount = 1000
  request.tax_amount = 1
  request.products = [get_klarna_product]
  request
end

private def get_klarna_product
  klarna_product = CheckoutSdk::Previous::Apm::KlarnaProduct.new
  klarna_product.name = 'Brown leather belt'
  klarna_product.quantity = 1
  klarna_product.unit_price = 1000
  klarna_product.tax_rate = 0
  klarna_product.total_amount = 1000
  klarna_product.total_tax_amount = 0
  klarna_product
end
