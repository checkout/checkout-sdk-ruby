RSpec.describe CheckoutSdk::Forward do

  skip 'This test requires a valid id or Token source' do
    describe '#forward_request' do
      it 'sends a forward request and returns destination_response' do
        request = {
          source: {
            id: 'src_v5rgkf3gdtpuzjqesyxmyodnya',
            type: 'id'
          },
          reference: 'ORD-5023-4E89',
          processing_channel_id: 'pc_azsiyswl7bwe2ynjzujy7lcjca',
          network_token: {
            enabled: true,
            request_cryptogram: false
          },
          destination_request: {
            url: 'https://example.com/payments',
            method: 'POST',
            headers: {
              encrypted: '<JWE encrypted JSON object with string values>',
              raw: {
                'Idempotency-Key' => 'xe4fad12367dfgrds',
                'Content-Type' => 'application/json'
              }
            },
            body: '{"amount": 1000, "currency": "USD", "reference": "some_reference", "source": {"type": "card", "number": "{{card_number}}", "expiry_month": "{{card_expiry_month}}", "expiry_year": "{{card_expiry_year_yyyy}}", "name": "Ali Farid"}, "payment_type": "Regular", "authorization_type": "Final", "capture": true, "processing_channel_id": "pc_xxxxxxxxxxx", "risk": {"enabled": false}, "merchant_initiated": true}',
            signature: {
              type: 'dlocal',
              dlocal_parameters: {
                secret_key: '9f439fe1a9f96e67b047d3c1a28c33a2e'
              }
            }
          }
        }

        response = client.forward_request(request)

        expect(response).to include('request_id', 'destination_response')
        expect(response['destination_response']).to include('status', 'body')
      end
    end

    describe '#get' do
      it 'retrieves a forward request by ID' do
        forward_id = 'fwd_01HK153X00VZ1K15Z3HYC0QGPN'
        response = client.get(forward_id)

        expect(response).to include(
                              'request_id',
                              'reference',
                              'destination_request',
                              'destination_response'
                            )
        expect(response['destination_response']['status']).to eq(201)
      end
    end
  end
end
