# frozen_string_literal: true

RSpec.describe CheckoutSdk::ApiClient do
  let(:configuration) do
    double(
      'CheckoutConfiguration',
      http_client: Faraday.new,
      multipart_http_client: Faraday.new,
      logger: Logger.new(STDOUT)
    )
  end

  let(:api_client) { CheckoutSdk::ApiClient.new(configuration, 'https://api.sandbox.checkout.com') }

  describe '#parse_response' do
    context 'when the response is successful' do
      it 'parses the response correctly for valid JSON' do
        response = double('Response', status: 200, body: '{"key":"value"}', headers: { 'Content-Type' => 'application/json' })
        allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
          OpenStruct.new(status_code: 200, body: response.body)
        )
        parsed_response = api_client.send(:parse_response, response)
        expect(parsed_response.key).to eq('value')
        expect(parsed_response.http_metadata.status_code).to eq(200)
      end

      it 'returns an OpenStruct object with items for an array response' do
        response = double('Response', status: 200, body: '[{"item":"value"}]', headers: { 'Content-Type' => 'application/json' })
        allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
          OpenStruct.new(status_code: 200, body: response.body)
        )
        parsed_response = api_client.send(:parse_response, response)
        expect(parsed_response.items).to be_an(Array)
        expect(parsed_response.items.first.item).to eq('value')
        expect(parsed_response.http_metadata.status_code).to eq(200)
      end

      it 'wraps primitive JSON values in OpenStruct with contents key' do
        response = double('Response', status: 200, body: '123', headers: { 'Content-Type' => 'application/json' })
        allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
          OpenStruct.new(status_code: 200, body: response.body)
        )
        parsed_response = api_client.send(:parse_response, response)
        expect(parsed_response.contents).to eq(123)
        expect(parsed_response.http_metadata.status_code).to eq(200)
      end
    end

    context 'when the response body is nil' do
      it 'returns an empty OpenStruct' do
        response = double('Response', status: 200, body: nil, headers: { 'Content-Type' => 'application/json' })
        allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
          OpenStruct.new(status_code: 200)
        )
        parsed_response = api_client.send(:parse_response, response)
        expect(parsed_response).to be_a(OpenStruct)
        expect(parsed_response.to_h.keys).to contain_exactly(:http_metadata)
        expect(parsed_response.http_metadata.status_code).to eq(200)
      end
    end

    context 'when the response body is an empty string' do
      it 'returns an empty OpenStruct' do
        response = double('Response', status: 200, body: '', headers: { 'Content-Type' => 'application/json' })
        allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
          OpenStruct.new(status_code: 200)
        )
        parsed_response = api_client.send(:parse_response, response)
        expect(parsed_response).to be_a(OpenStruct)
        expect(parsed_response.to_h.keys).to contain_exactly(:http_metadata)
        expect(parsed_response.http_metadata.status_code).to eq(200)
      end
    end

    context 'when the response status is not in the 2xx range' do
      it 'raises a CheckoutApiException for status code less than 200' do
        response = double('Response', status: 199, body: '{}')
        allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
          OpenStruct.new(status_code: 199, body: response.body)
        )
        expect do
          api_client.send(:parse_response, response)
        end.to raise_error(CheckoutSdk::CheckoutApiException) do |error|
          expect(error.message).to eq("The API response status code (199) does not indicate success.")
          expect(error.http_metadata.status_code).to eq(199)
        end
      end

      it 'raises a CheckoutApiException for client errors (4xx)' do
        response = double('Response', status: 400, body: '{"error":"Bad Request"}')
        allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
          OpenStruct.new(status_code: 400, body: response.body)
        )
        expect do
          api_client.send(:parse_response, response)
        end.to raise_error(CheckoutSdk::CheckoutApiException) do |error|
          expect(error.message).to include("The API response status code (400) does not indicate success.")
          expect(error.error_details.error).to eq('Bad Request')
          expect(error.http_metadata.status_code).to eq(400)
        end
      end

      it 'raises a CheckoutApiException for server errors (5xx)' do
        response = double('Response', status: 500, body: '{"error":"Server Error"}')
        allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
          OpenStruct.new(status_code: 500, body: response.body)
        )
        expect do
          api_client.send(:parse_response, response)
        end.to raise_error(CheckoutSdk::CheckoutApiException) do |error|
          expect(error.message).to include("The API response status code (500) does not indicate success.")
          expect(error.error_details.error).to eq('Server Error')
          expect(error.http_metadata.status_code).to eq(500)
        end
      end
    end

    context 'when the response body is invalid JSON' do
      it 'raises a CheckoutApiException with JSON parsing error' do
        response = double('Response', status: 200, body: '{invalid_json}', headers: { 'Content-Type' => 'application/json' })
        allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).with(response).and_return(
          OpenStruct.new(status_code: 200, body: response.body)
        )
        expect do
          api_client.send(:parse_response, response)
        end.to raise_error(CheckoutSdk::CheckoutApiException, /Error parsing JSON: .*/)
      end
    end

    context 'when an unexpected exception occurs' do
      it 'logs the error and re-raises the exception' do
        response = double('Response', status: 200, body: '{"key":"value"}')
        allow(CheckoutSdk::CheckoutUtils).to receive(:map_to_http_metadata).and_raise(StandardError.new("Unexpected failure"))
        expect(api_client.log).to receive(:error).with("Unexpected error occurred: Unexpected failure")
        expect do
          api_client.send(:parse_response, response)
        end.to raise_error(StandardError, "Unexpected failure")
      end
    end
  end
end