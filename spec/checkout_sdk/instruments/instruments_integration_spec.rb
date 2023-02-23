RSpec.describe CheckoutSdk::Instruments do

  describe '.create' do
    context 'when requesting a card instrument token' do
      it 'returns a card instrument token' do
        account_holder = CheckoutSdk::Common::AccountHolder.new
        account_holder.first_name = 'John'
        account_holder.last_name = 'Smith'
        account_holder.billing_address = address
        account_holder.phone = phone

        request = CheckoutSdk::Instruments::InstrumentToken.new
        request.token = create_token.token
        request.account_holder = account_holder

        TrueClass
        response = default_sdk.instruments.create(request)

        expect(response).not_to be nil
        expect(response.id).not_to be nil
        expect(response.type).to eq(CheckoutSdk::Common::InstrumentType::CARD)
        expect(response.expiry_month).not_to be nil
        expect(response.expiry_year).not_to be nil
        expect(response.scheme).not_to be nil
        expect(response.last4).not_to be nil
        expect(response.bin).not_to be nil
        expect(response.card_type).not_to be nil
        expect(response.card_category).not_to be nil
        expect(response.issuer_country).not_to be nil
      end
    end

    context 'when requesting card token instrument with missing data' do
      it 'raises an error' do
        request = CheckoutSdk::Instruments::InstrumentToken.new

        expect { default_sdk.instruments.create(request) }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.get' do
    context 'when fetching a valid instrument' do
      subject(:instrument) { create_card_token_instrument }
      it 'returns a valid card token instrument' do
        response = default_sdk.instruments.get(instrument.id)

        expect(response).not_to be nil
        expect(response.id).not_to be nil
        expect(response.type).to eq(CheckoutSdk::Common::InstrumentType::CARD)
        expect(response.expiry_month).not_to be nil
        expect(response.expiry_year).not_to be nil
        expect(response.scheme).not_to be nil
        expect(response.last4).not_to be nil
        expect(response.bin).not_to be nil
        expect(response.card_type).not_to be nil
        expect(response.card_category).not_to be nil
        expect(response.issuer_country).not_to be nil
      end
    end

    context 'when fetching inexistent instrument' do
      it 'raises an exception' do
        expect { default_sdk.instruments.get("not_found") }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.update' do
    before(:all) do
      @instrument = create_card_token_instrument
    end
    context 'when updating card token instrument' do
      it 'should update successfully' do
        request = CheckoutSdk::Instruments::UpdateInstrumentCard.new
        request.expiry_month = 12
        request.expiry_year = 2030
        request.name = "New Name"

        response = default_sdk.instruments.update(@instrument.id, request)
        expect(response).not_to be nil
      end

      it 'should have new values for updated fields' do
        response = default_sdk.instruments.get(@instrument.id)

        expect(response).not_to be nil
        expect(response.expiry_month).to eq(12)
        expect(response.expiry_year).to eq(2030)
        expect(response.name).to eq("New Name")
      end
    end

    context 'when updating inexistent instrument' do
      it 'raises an exception' do
        expect { default_sdk.instruments.update("not_found", nil) }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.delete' do
    subject(:instrument) { create_card_token_instrument }
    context 'when deleting an existent instrument' do
      it 'should return http: 204' do
        response = default_sdk.instruments.delete(instrument.id)

        expect(response).not_to be nil
        expect(response.http_metadata.status_code).to eq 204
      end
    end

    context 'when deleting an inexistent instrument' do
      it 'raises an error' do
        expect { default_sdk.instruments.delete('not_found') }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.get_bank_account_field_formatting' do
    context 'when fetching for bank account field formatting with correct parameters' do
      it 'retrieves bank account field formatting' do
        query = CheckoutSdk::Instruments::BankAccountFieldQuery.new
        query.account_holder_type = CheckoutSdk::Common::AccountHolderType::INDIVIDUAL
        query.payment_network = CheckoutSdk::Instruments::PaymentNetwork::LOCAL

        response = oauth_sdk.instruments.get_bank_account_field_formatting CheckoutSdk::Common::Country::GB,
                                                                           CheckoutSdk::Common::Currency::GBP,
                                                                           query

        assert_response response, %w[sections]
        expect(response.sections.length).to eq 3

        response.sections.each { |section|
          assert_response section, %w[name
                                      fields]
          section.fields.each { |field|
            assert_response field, %w[id
                                      display
                                      type]
          }
        }
      end
    end
  end

end

private def create_token
  request = CheckoutSdk::Tokens::CardTokenRequest.new
  request.number = visa_card.card_number
  request.expiry_month = visa_card.expiry_month
  request.expiry_year = visa_card.expiry_year

  default_sdk.tokens.request_token(request)
end

private def create_card_token_instrument
  account_holder = CheckoutSdk::Common::AccountHolder.new
  account_holder.first_name = 'John'
  account_holder.last_name = 'Smith'
  account_holder.billing_address = address
  account_holder.phone = phone

  request = CheckoutSdk::Instruments::InstrumentToken.new
  request.token = create_token.token
  request.account_holder = account_holder

  default_sdk.instruments.create(request)
end