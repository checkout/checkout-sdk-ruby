require 'spec_helper'

RSpec.describe CheckoutSdk::RequestToken do
  let(:type) { "card" }
  let(:request_token) { CheckoutSdk::RequestToken.new }
  let(:token_data_version) { "EC_v1" }
  let(:token_data_data) { "Base64" }
  let(:token_data_signature) { "Signature" }
  let(:token_data_header) { "" }
  let(:token_data_signature) { }
  let(:token_data_protocolVersion) { "ECv0" }
  let(:token_data_signedMessage) { "signedMessage" }
  let(:card_number) { "4242424242424242" }
  let(:card_expiry_month) { 6 }
  let(:card_expiry_year) { 25 }
  let(:card_name) { "Elmo and Friends" }
  let(:card_cvv) { "123" }
  let(:billing_address_line1) { "Sesame street 1" }
  let(:billing_address_line2) { "" }
  let(:billing_city) { "Sesame city" }
  let(:billing_state) { "Sesame state" }
  let(:billing_zip) { "12345" }
  let(:billing_country) { "Sesame country" }
  let(:phone_country_code) { "+1" }
  let(:phone_number) { "415 555 2671" }
  let(:applepay_type) {
    {
      type: type,
      token_data: {
        version: token_data_version,
        data: token_data_data,
        signature: token_data_signature,
        header: token_data_header
      }
    }
  }
  let(:googlepay_type) {
    {
      type: type,
      token_data: {
        signature: token_data_signature,
        protocolVersion: token_data_protocolVersion,
        signedMessage: token_data_signedMessage
      }
    }
  }
  let(:card_type) {
    {
      type: type,
      number: card_number,
      expiry_month: card_expiry_month,
      expiry_year: card_expiry_year,
      name: card_name,
      cvv: card_cvv,
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
      }
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
        request_token.type = "card"

        expect(get_keys(request_token.data)).to eql(get_keys(card_type))
      end
    end

    context "googlepay" do
      it "uses card settings" do
        request_token.type = "googlepay"

        expect(get_keys(request_token.data)).to eql(get_keys(googlepay_type))
      end
    end

    context "applepay" do
      it "uses card settings" do
        request_token.type = "applepay"

        expect(get_keys(request_token.data)).to eql(get_keys(applepay_type))
      end
    end
  end
end
