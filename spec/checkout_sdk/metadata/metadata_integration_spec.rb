# frozen_string_literal: true

RSpec.describe CheckoutSdk::Metadata do

  describe '.request_card_metadata' do
    subject(:card_metadata) { oauth_sdk.metadata.request_card_metadata card_request }
    context 'when requesting card metadata with valid card number' do
      it { is_valid_card_metadata card_metadata }
    end

    subject(:card_metadata) { oauth_sdk.metadata.request_card_metadata bin_request }
    context 'when requesting card metadata with valid bin number' do
      it { is_valid_card_metadata card_metadata }
    end

    subject(:card_metadata) { oauth_sdk.metadata.request_card_metadata token_request }
    context 'when requesting card metadata with valid token' do
      it { is_valid_card_metadata card_metadata }
    end
  end
end

def card_request
  source = CheckoutSdk::Metadata::CardMetadataSource.new
  source.number = visa_card.card_number

  request = CheckoutSdk::Metadata::MetadataRequest.new
  request.source = source
  request.format = CheckoutSdk::Metadata::Format::BASIC

  request
end

def bin_request
  source = CheckoutSdk::Metadata::BinMetadataSource.new
  source.bin = '42424242'

  request = CheckoutSdk::Metadata::MetadataRequest.new
  request.source = source
  request.format = CheckoutSdk::Metadata::Format::BASIC

  request
end

def token_request
  token_request = CheckoutSdk::Tokens::CardTokenRequest.new
  token_request.number = visa_card.card_number
  token_request.expiry_month = visa_card.expiry_month
  token_request.expiry_year = visa_card.expiry_year

  token = default_sdk.tokens.request_token(token_request)

  source = CheckoutSdk::Metadata::TokenMetadataSource.new
  source.token = token.token

  request = CheckoutSdk::Metadata::MetadataRequest.new
  request.source = source
  request.format = CheckoutSdk::Metadata::Format::BASIC

  request
end

def is_valid_card_metadata(card_metadata)
  assert_response card_metadata, %w[issuer_country_name
                                    product_id
                                    product_type
                                    scheme
                                    bin
                                    card_type
                                    card_category
                                    issuer_country]

  expect(card_metadata.bin).to eq '42424242'
end
