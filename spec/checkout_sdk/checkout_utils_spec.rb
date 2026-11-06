# frozen_string_literal: true

RSpec.describe CheckoutSdk::CheckoutUtils do
  let(:backslash) { '\\' }

  describe '.encode_path_segment' do
    it 'keeps unreserved characters unchanged' do
      value = 'AZaz09-._~'
      expect(described_class.encode_path_segment(value)).to eq(value)
    end

    it 'percent-encodes reserved characters with upper-case hex' do
      expect(described_class.encode_path_segment('a?b#c%d e;f:g@h&i=j+k'))
        .to eq('a%3Fb%23c%25d%20e%3Bf%3Ag%40h%26i%3Dj%2Bk')
    end

    it 'percent-encodes non-ASCII text as UTF-8 bytes' do
      expect(described_class.encode_path_segment('é€')).to eq('%C3%A9%E2%82%AC')
    end

    it 'percent-encodes text in another encoding as UTF-8 bytes' do
      expect(described_class.encode_path_segment('é'.encode(Encoding::ISO_8859_1))).to eq('%C3%A9')
    end

    it 'keeps dots that are not a whole segment' do
      expect(described_class.encode_path_segment('...')).to eq('...')
      expect(described_class.encode_path_segment('a..b')).to eq('a..b')
    end

    it 'converts Integer and Symbol values' do
      expect(described_class.encode_path_segment(42)).to eq('42')
      expect(described_class.encode_path_segment(:files)).to eq('files')
    end

    it 'returns a UTF-8 string' do
      expect(described_class.encode_path_segment('é').encoding).to eq(Encoding::UTF_8)
    end

    it 'validates text in an encoding that is not ASCII compatible after converting it' do
      expect(described_class.encode_path_segment('ab'.encode(Encoding::UTF_16LE))).to eq('ab')
    end

    it 'accepts binary text that holds only ASCII characters' do
      expect(described_class.encode_path_segment('pay_1'.b)).to eq('pay_1')
    end

    it 'percent-encodes control characters outside ASCII' do
      expect(described_class.encode_path_segment("a\u0085b")).to eq('a%C2%85b')
    end

    invalid_values = [nil, '', '.', '..', :'..', 'a/b', 'a\\b', "a\nb", "a\rb", "a\u0000b", "a\u007Fb",
                      '..'.encode(Encoding::UTF_16LE), '.'.encode(Encoding::UTF_32LE),
                      '..'.dup.force_encoding(Encoding::UTF_7), 'a/b'.encode(Encoding::UTF_16BE),
                      "a\xFFb".dup.force_encoding(Encoding::UTF_8), "\xC3\xA9".b]
    invalid_values.each do |value|
      label = value.is_a?(String) ? value.encoding : value.class
      it "raises CheckoutArgumentException for #{value.inspect} (#{label})" do
        expect { described_class.encode_path_segment(value) }
          .to raise_error(CheckoutSdk::CheckoutArgumentException, /\AInvalid path segment/)
      end
    end

    it 'raises CheckoutArgumentException when to_s does not return a String' do
      value = Object.new
      def value.to_s
        42
      end
      expect { described_class.encode_path_segment(value) }
        .to raise_error(CheckoutSdk::CheckoutArgumentException, /\AInvalid path segment/)
    end
  end

  describe '.loggable_path' do
    it 'keeps a plain path unchanged' do
      expect(described_class.loggable_path('payments/pay_123/captures')).to eq('payments/pay_123/captures')
    end

    it 'leaves out the query string' do
      expect(described_class.loggable_path('events?from=2026-01-01&reference=ref')).to eq('events')
    end

    it 'escapes control characters' do
      expect(described_class.loggable_path("payments/a\nb\rc\td\e")).to eq('payments/a\nb\rc\td\e')
    end

    it 'escapes unicode line and paragraph separators' do
      expected = "payments/a#{backslash}u2028b#{backslash}u2029c"

      expect(described_class.loggable_path("payments/a\u{2028}b\u{2029}c")).to eq(expected)
    end

    it 'accepts invalid byte sequences and nil' do
      expect(described_class.loggable_path("payments/\xFF\n".b)).to eq("payments/\u{FFFD}#{backslash}n")
      expect(described_class.loggable_path(nil)).to eq('')
    end

    it 'converts text in another encoding to UTF-8' do
      expect(described_class.loggable_path("payments/\u00E9\n".encode(Encoding::UTF_16LE)))
        .to eq("payments/\u00E9#{backslash}n")
    end
  end

  describe '.error_message' do
    let(:prefix) { 'Request failed.' }

    it 'adds the key and value pairs of a JSON object on one line' do
      body = '{"error_type":"request_invalid","error_codes":["card_invalid"],"message":"a\\nb","source":{"a":1}}'
      source = { 'a' => 1 }

      expect(described_class.error_message(prefix, body))
        .to eq('Request failed. Details: error_type: request_invalid, error_codes: ["card_invalid"], ' \
               "message: a#{backslash}nb, source: #{source}.")
    end

    it 'returns the prefix alone for an empty body or an empty JSON object' do
      expect(described_class.error_message(prefix, nil)).to eq(prefix)
      expect(described_class.error_message(prefix, " {} \n", include_text_body: true)).to eq(prefix)
    end

    it 'adds a body that is not a JSON object only when asked to' do
      expect(described_class.error_message(prefix, '[1,2]')).to eq(prefix)
      expect(described_class.error_message(prefix, " Bad Request \n", include_text_body: true))
        .to eq('Request failed. Details: Bad Request.')
    end

    it 'shortens long details and escapes them' do
      text_body = described_class.error_message(prefix, "a\n#{'x' * 300}", include_text_body: true)
      json_body = described_class.error_message(prefix, { error: 'x' * 300 }.to_json)

      expect(text_body).to eq("Request failed. Details: a#{backslash}n#{'x' * 254}....")
      expect(json_body).to eq("Request failed. Details: error: #{'x' * 249}....")
    end
  end

  describe '.without_request_data' do
    let(:request) { { method: :get, url: URI('https://api.example.com/events?reference=order-1'), headers: { 'Authorization' => 'secret-value' } } }

    def expect_clean(error)
      expect(error.inspect).not_to include('secret-value')
      expect(error.message).to eq('the server responded with status 500 for GET https://api.example.com/events')
    end

    it 'keeps the class, response and backtrace' do
      original = Faraday::ServerError.new({ status: 500, headers: { 'Cko-Request-Id' => 'id' }, body: '{}', request: request })
      original.set_backtrace(%w[frame_one frame_two])

      result = described_class.without_request_data(original)

      expect(result).to be_a(Faraday::ServerError)
      expect(result.response).to eq(status: 500, headers: { 'Cko-Request-Id' => 'id' }, body: '{}')
      expect(result.backtrace).to eq(%w[frame_one frame_two])
      expect_clean(result)
    end

    it 'handles a frozen response' do
      original = Faraday::ServerError.new({ status: 500, body: '{}', request: request }.freeze)

      result = described_class.without_request_data(original)

      expect(result.response).not_to have_key(:request)
      expect_clean(result)
    end

    it 'handles a Faraday::Response' do
      env = Faraday::Env.from(status: 500, body: '{}', response_headers: {}, request_headers: { 'Authorization' => 'secret-value' })
      original = Faraday::ServerError.new('failed', Faraday::Response.new(env))

      result = described_class.without_request_data(original)

      expect(result.inspect).not_to include('secret-value')
      expect(result.response).to eq(status: 500, headers: {}, body: '{}')
      expect(result.message).to eq('the server responded with status 500')
    end

    it 'keeps the class and wrapped exception for a class with another constructor' do
      custom = Class.new(Faraday::ServerError) do
        def initialize(code, response)
          super(code.to_s, response)
        end
      end
      original = custom.new(500, { status: 500, request: request })
      original.instance_variable_set(:@wrapped_exception, IOError.new('closed'))

      result = described_class.without_request_data(original)

      expect(result).to be_a(custom)
      expect(result.wrapped_exception).to be_a(IOError)
      expect_clean(result)
    end

    it 'returns an error without response unchanged' do
      original = Faraday::TimeoutError.new

      expect(described_class.without_request_data(original)).to be(original)
    end
  end

  describe 'default clients' do
    %i[build_default_client build_multipart_client].each do |builder|
      it "#{builder} raises errors without request data" do
        stubs = Faraday::Adapter::Test::Stubs.new { |stub| stub.get('/payments') { [500, {}, ''] } }
        client = described_class.public_send(builder)
        client.builder.adapter :test, stubs

        expect { client.get('/payments') }.to raise_error(Faraday::ServerError) do |error|
          expect(error.response).not_to have_key(:request)
        end
      end
    end
  end
end
