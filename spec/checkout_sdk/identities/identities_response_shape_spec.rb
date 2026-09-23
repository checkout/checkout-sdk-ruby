# frozen_string_literal: true

# Part A of the 2026-09-02 swagger delta, at the response side.
#
# The client specs mock the ApiClient and only prove the path, and the ADV and IDDV integration
# specs are wrapped in `skip`, so before this file nothing runnable ever parsed an assets payload.
# These drive the real parse path (parse_response -> parse_body -> deep_convert_to_ostruct), which
# is what actually hands a caller their result.
#
# The payloads are the swagger examples verbatim, from components.examples, apart from shortened
# hrefs. asset_url is the only link AdvAttemptAsset and IddvAttemptAsset declare, and it is
# required, so using the spec's own example rather than a hand-written fixture is the point.
RSpec.describe 'Identities response shapes' do
  let(:configuration) do
    double(
      'CheckoutConfiguration',
      http_client: Faraday.new,
      multipart_http_client: Faraday.new,
      logger: Logger.new(File::NULL)
    )
  end

  let(:api_client) { CheckoutSdk::ApiClient.new(configuration, 'https://api.sandbox.checkout.com') }

  def parse(body, status: 200)
    response = double('Response', status: status, body: body,
                                  headers: { 'Content-Type' => 'application/json' })
    allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
      OpenStruct.new(status_code: status, body: body)
    )
    api_client.send(:parse_response, response)
  end

  let(:adv_attempt_assets) do
    <<~JSON
      {
        "total_count": 1,
        "skip": 0,
        "limit": 10,
        "data": [
          {
            "type": "document",
            "_links": {
              "asset_url": { "href": "https://storage-b.env.ubble.ai/ubble-ai/NDY/address_document.png" }
            }
          }
        ],
        "_links": {
          "self": { "href": "https://idv.checkout.com/address-document-verifications/adv_1/attempts/adva_1/assets" },
          "next": { "href": "https://idv.checkout.com/address-document-verifications/adv_1/attempts/adva_1/assets?skip=10" },
          "previous": { "href": "https://idv.checkout.com/address-document-verifications/adv_1/attempts/adva_1/assets?skip=0" }
        }
      }
    JSON
  end

  let(:iddv_attempt_assets) do
    <<~JSON
      {
        "total_count": 2,
        "skip": 0,
        "limit": 10,
        "data": [
          {
            "type": "document_front_image",
            "_links": { "asset_url": { "href": "https://storage-b.env.ubble.ai/ubble-ai/NDY/document_front.png" } }
          },
          {
            "type": "document_back_image",
            "_links": { "asset_url": { "href": "https://storage-b.env.ubble.ai/ubble-ai/NDY/document_back.png" } }
          }
        ],
        "_links": {
          "self": { "href": "https://idv.checkout.com/id-document-verifications/iddv_1/attempts/datp_1/assets" }
        }
      }
    JSON
  end

  describe 'the address document verification attempt assets response' do
    it 'parses the swagger example' do
      response = parse(adv_attempt_assets)

      expect(response.total_count).to eq(1)
      expect(response.skip).to eq(0)
      expect(response.limit).to eq(10)
      expect(response.data.length).to eq(1)
      expect(response.data.first.type).to eq('document')
      expect(response.data.first._links.asset_url.href).to include('address_document.png')
      expect(response.http_metadata.status_code).to eq(200)
    end

    it 'exposes the pagination links, without which skip and limit cannot be walked' do
      response = parse(adv_attempt_assets)

      expect(response._links.self.href).to end_with('/assets')
      expect(response._links.next.href).to include('skip=10')
      expect(response._links.previous.href).to include('skip=0')
    end

    it 'names the asset link asset_url and not download' do
      asset = parse(adv_attempt_assets).data.first

      expect(asset._links.asset_url).not_to be_nil
      expect(asset._links.download).to be_nil
    end
  end

  describe 'the ID document verification attempt assets response' do
    it 'parses the swagger example, including both asset types' do
      response = parse(iddv_attempt_assets)

      expect(response.total_count).to eq(2)
      expect(response.data.length).to eq(2)
      expect(response.data.map(&:type)).to eq(%w[document_front_image document_back_image])
      expect(response.data[0]._links.asset_url.href).to include('document_front.png')
      expect(response.data[1]._links.asset_url.href).to include('document_back.png')
    end

    it 'names the asset link asset_url and not download' do
      parse(iddv_attempt_assets).data.each do |asset|
        expect(asset._links.asset_url).not_to be_nil
        expect(asset._links.download).to be_nil
      end
    end
  end

  # T7: data declares minItems 0, so an attempt with no assets yet is a legal page.
  describe 'an empty assets page' do
    it 'parses with an empty data array' do
      response = parse(
        '{"total_count":0,"skip":0,"limit":10,"data":[],' \
        '"_links":{"self":{"href":"https://idv.checkout.com/a"}}}'
      )

      expect(response.total_count).to eq(0)
      expect(response.data).to eq([])
      expect(response._links.self.href).not_to be_nil
    end
  end

  # Part F M1: the list-attempts responses gained nothing structurally, but the pagination members
  # are what the new skip and limit parameters page through, so they are worth pinning.
  describe 'a paginated attempts list response' do
    it 'exposes total_count, skip, limit and the links' do
      response = parse(
        '{"total_count":25,"skip":10,"limit":10,"data":[{"id":"adva_1","status":"completed"}],' \
        '"_links":{"self":{"href":"https://idv.checkout.com/a?skip=10"},' \
        '"next":{"href":"https://idv.checkout.com/a?skip=20"},' \
        '"previous":{"href":"https://idv.checkout.com/a?skip=0"}}}'
      )

      expect(response.total_count).to eq(25)
      expect(response.skip).to eq(10)
      expect(response.limit).to eq(10)
      expect(response.data.first.status).to eq('completed')
      expect(response._links.next.href).to include('skip=20')
    end
  end

  # Part D: the API answers 422 with error code encryption_key_required when return-encrypted-cvv
  # is set to "true" without an Encryption-Key header. parse_response raises for status >= 400, so
  # the error body has to survive into the exception for a caller to act on it.
  describe 'the card update 422' do
    it 'raises CheckoutApiException carrying the encryption_key_required code' do
      body = '{"request_id":"0HLHPN8802NUF:00000003",' \
             '"error_type":"request_invalid",' \
             '"error_codes":["encryption_key_required"]}'
      response = double('Response', status: 422, body: body,
                                    headers: { 'Content-Type' => 'application/json' })
      allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
        OpenStruct.new(status_code: 422, body: body)
      )

      expect { api_client.send(:parse_response, response) }
        .to raise_error(CheckoutSdk::CheckoutApiException) { |error|
          expect(error.http_metadata.status_code).to eq(422)
          expect(error.error_details.error_type).to eq('request_invalid')
          expect(error.error_details.error_codes).to include('encryption_key_required')
        }
    end
  end

  # The success counterpart: encrypted_cvv is returned only when the headers ask for it, so it is
  # absent on an ordinary update.
  describe 'the card update response' do
    it 'exposes encrypted_cvv when the headers requested it' do
      response = parse('{"last_modified_date":"2026-06-01T10:00:00Z","encrypted_cvv":"oJMoNMEEUiQKYOsQ4Zd"}')

      expect(response.encrypted_cvv).to eq('oJMoNMEEUiQKYOsQ4Zd')
      expect(response.last_modified_date).to eq('2026-06-01T10:00:00Z')
    end

    it 'leaves encrypted_cvv nil on an ordinary update' do
      response = parse('{"last_modified_date":"2026-06-01T10:00:00Z"}')

      expect(response.encrypted_cvv).to be_nil
    end
  end

  # Part C is a no-op in ruby because responses are OpenStruct, but the key still changed, so the
  # report response is worth one assertion in each direction.
  describe 'the PDF report response' do
    it 'exposes pdf_report' do
      response = parse('{"pdf_report":"https://www.example.com/reports/idv_1.pdf"}')

      expect(response.pdf_report).to end_with('.pdf')
    end

    it 'leaves signed_url nil, since IdvPdf no longer declares it' do
      response = parse('{"pdf_report":"https://www.example.com/reports/idv_1.pdf"}')

      expect(response.signed_url).to be_nil
    end
  end
end
