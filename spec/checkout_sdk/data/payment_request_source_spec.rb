require 'spec_helper'

RSpec.describe CheckoutSdk::PaymentRequestSource do
  subject(:payment_request_source) { CheckoutSdk::PaymentRequestSource.new }

  let(:type) { "card" }
  let(:card_number) { "4242424242424242" }
  let(:card_expiry_month) { 6 }
  let(:card_expiry_year) { 25 }
  let(:card_name) { "Elmo and Friends" }
  let(:card_cvv) { "123" }
  let(:card_stored) { false }
  let(:billing_address_line1) { "Sesame street 1" }
  let(:billing_address_line2) { "" }
  let(:billing_city) { "Sesame city" }
  let(:billing_state) { "Sesame state" }
  let(:billing_zip) { "12345" }
  let(:billing_country) { "Sesame country" }
  let(:phone_country_code) { "+1" }
  let(:phone_number) { "415 555 2671" }
  let(:id) { "12345678" }
  let(:cvv) { "123" }
  let(:token) { "tok_4gzeau5o2uqubbk6fufs3m7p54" }
  let(:customer_id) { "12345678" }
  let(:customer_email) { "elmo@friends.sesame" }
  let(:expected_card_source) {
    {
      type: type,
      number: card_number,
      expiry_month: card_expiry_month,
      expiry_year: card_expiry_year,
      name: card_name,
      cvv: card_cvv,
      stored: card_stored,
      billing_address:  {
        address_line1: billing_address_line1,
        address_line2: billing_address_line2,
        city: billing_city,
        state: billing_state,
        zip: billing_zip,
        country: billing_country
      },
      phone: {
        country_code: phone_country_code,
        number: phone_number
      },
    }
  }
  let(:expected_id_source) {
    {
      type: type,
      id: id,
      cvv: cvv
    }
  }
  let(:expected_token_source) {
    {
      type: type,
      token: token,
      billing_address:  {
        address_line1: billing_address_line1,
        address_line2: billing_address_line2,
        city: billing_city,
        state: billing_state,
        zip: billing_zip,
        country: billing_country
      },
      phone: {
        country_code: phone_country_code,
        number: phone_number
      },
    }
  }
  let(:expected_customer_source) {
    {
      type: type,
      id: customer_id,
      email: customer_email
    }
  }

  def get_keys(hash)
    hash.map do |k, v|
      v = v.first if v.is_a?(Array);

      if v.is_a?(Hash)
        [k, get_keys(v)]
      else
        k
      end
    end
  end

  describe "#data" do
    context "card" do
      it "uses card settings" do
        payment_request_source.type = "card"

        expect(get_keys(payment_request_source.data[:source])).to eql(get_keys(expected_card_source))
      end
    end

    context "id" do
      it "uses id settings" do
        payment_request_source.type = "id"

        expect(get_keys(payment_request_source.data[:source])).to eql(get_keys(expected_id_source))
      end
    end

    context "token" do
      it "uses token settings" do
        payment_request_source.type = "token"

        expect(get_keys(payment_request_source.data[:source])).to eql(get_keys(expected_token_source))
      end
    end

    context "token" do
      it "uses customer settings" do
        payment_request_source.type = "customer"

        expect(get_keys(payment_request_source.data[:source])).to eql(get_keys(expected_customer_source))
      end
    end

    describe '3DS' do
      it 'sets enabled' do
        payment_request_source.threeds_enabled = true
        expect(payment_request_source.data['3ds'][:enabled]).to eq(true)
      end

      it 'sets the attempt_n3d' do
        payment_request_source.threeds_attempt_n3d = true
        expect(payment_request_source.data['3ds'][:attempt_n3d]).to eq(true)
      end

      it 'sets the eci' do
        payment_request_source.threeds_eci = "05"
        expect(payment_request_source.data['3ds'][:eci]).to eq('05')
      end

      it 'sets the cryptogram' do
        payment_request_source.threeds_cryptogram = "asjdkfhkasjhdfkhasdifkouj"
        expect(payment_request_source.data['3ds'][:cryptogram]).to eq('asjdkfhkasjhdfkhasdifkouj')
      end

      it 'sets the xid' do
        payment_request_source.threeds_xid = "asjdkfhkasjhdfkhasdifkouj"
        expect(payment_request_source.data['3ds'][:xid]).to eq('asjdkfhkasjhdfkhasdifkouj')
      end

      it 'sets the version' do
        payment_request_source.threeds_version = "2.0.0"
        expect(payment_request_source.data['3ds'][:version]).to eq('2.0.0')
      end

      it 'sets the exemption' do
        payment_request_source.threeds_exemption = "secure_corporate_payment"
        expect(payment_request_source.data['3ds'][:exemption]).to eq('secure_corporate_payment')
      end

      it 'sets the challenge_indicator' do
        payment_request_source.threeds_challenge_indicator = "challenge_requested_mandate"
        expect(payment_request_source.data['3ds'][:challenge_indicator]).to eq('challenge_requested_mandate')
      end
    end
  end
end
