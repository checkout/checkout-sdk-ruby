RSpec.describe CheckoutSdk::Previous::Instruments do

  describe '.create', skip: 'unavailable' do
    context 'when requesting an instrument token' do
      it 'returns an instrument token' do
        request = CheckoutSdk::Previous::Instruments::Instrument.new
        request.token = create_token_previous.token
        request.account_holder = common_account_holder
        request.customer = common_customer_request

        TrueClass
        response = previous_sdk.instruments.create(request)

        assert_response response, %w[id
                                     type
                                     expiry_month
                                     expiry_year
                                     scheme
                                     last4
                                     bin
                                     card_type
                                     card_category
                                     issuer_country]

        expect(response.type).to eq(CheckoutSdk::Common::InstrumentType::CARD)
      end
    end

    context 'when requesting an instrument token with missing data' do
      it 'raises an error' do
        request = CheckoutSdk::Previous::Instruments::Instrument.new

        expect { previous_sdk.instruments.create(request) }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.get', skip: 'unavailable' do
    context 'when fetching a valid instrument' do
      subject(:instrument) { create_instrument_token }
      it 'returns a valid card token instrument' do
        response = previous_sdk.instruments.get(instrument.id)

        assert_response response, %w[id
                                     type
                                     expiry_month
                                     expiry_year
                                     scheme
                                     last4
                                     bin
                                     card_type
                                     card_category
                                     issuer_country]

        expect(response.type).to eq(CheckoutSdk::Common::InstrumentType::CARD)
      end
    end

    context 'when fetching inexistent instrument' do
      it 'raises an exception' do
        expect { previous_sdk.instruments.get('not_found') }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.update', skip: 'unavailable' do
    before(:all) do
      @instrument = create_instrument_token
    end
    context 'when updating card token instrument' do
      it 'should update successfully' do
        request = CheckoutSdk::Previous::Instruments::UpdateInstrument.new
        request.expiry_month = 12
        request.expiry_year = 2030
        request.name = 'New Name'

        response = previous_sdk.instruments.update(@instrument.id, request)

        assert_response response
      end

      it 'should have new values for updated fields' do
        response = previous_sdk.instruments.get(@instrument.id)

        assert_response response, %w[expiry_month
                                     expiry_year
                                     name]

        expect(response.expiry_month).to eq(12)
        expect(response.expiry_year).to eq(2030)
        expect(response.name).to eq('New Name')
      end
    end

    context 'when updating inexistent instrument' do
      it 'raises an exception' do
        expect { previous_sdk.instruments.update('not_found', nil) }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.delete', skip: 'unavailable' do
    subject(:instrument) { create_instrument_token }
    context 'when deleting an existent instrument' do
      it 'should return http: 204' do
        response = previous_sdk.instruments.delete(instrument.id)

        expect(response).not_to be nil
        expect(response.http_metadata.status_code).to eq 204
      end
    end

    context 'when deleting an inexistent instrument' do
      it 'raises an error' do
        expect { previous_sdk.instruments.delete('not_found') }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end
end

private def create_token_previous
  request = CheckoutSdk::Tokens::CardTokenRequest.new
  request.number = visa_card.card_number
  request.expiry_month = visa_card.expiry_month
  request.expiry_year = visa_card.expiry_year
  request.cvv = visa_card.cvv
  request.name = visa_card.name
  request.billing_address = address
  request.phone = phone

  previous_sdk.tokens.request_token(request)
end

private def create_instrument_token
  request = CheckoutSdk::Previous::Instruments::Instrument.new
  request.token = create_token_previous.token
  request.account_holder = common_account_holder

  previous_sdk.instruments.create(request)
end
