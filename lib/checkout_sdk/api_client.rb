# frozen_string_literal: true

require 'csv'

module CheckoutSdk
  class ApiClient
    attr_accessor :client, :multipart_client, :log

    def initialize(configuration, uri)
      @client = configuration.http_client.clone
      @client.url_prefix = uri
      @multipart_client = configuration.multipart_http_client.clone
      @multipart_client.url_prefix = uri
      @log = configuration.logger
    end

    def invoke_get(path, authorization, params = nil, headers = nil)
      invoke(:get, path, authorization, params: params, extra_headers: headers)
    end

    def invoke_post(path, authorization, request = nil, idempotency_key = nil, headers = nil)
      invoke(:post, path, authorization, request, idempotency_key, params: nil, extra_headers: headers)
    end

    def invoke_put(path, authorization, request, headers = nil)
      invoke(:put, path, authorization, request, nil, params: nil, extra_headers: headers)
    end

    def invoke_patch(path, authorization, request = nil, headers = nil)
      invoke(:patch, path, authorization, request, nil, params: nil, extra_headers: headers)
    end

    def invoke_delete(path, authorization)
      invoke(:delete, path, authorization)
    end

    def submit_file(path, authorization, request)
      upload(path, authorization, request)
    end

    private

    def invoke(method, path, authorization, body = nil, idempotency_key = nil, params: nil, extra_headers: nil)
      path = append_params(path, params) unless params.nil?

      headers = default_headers(authorization)
      headers[:'Content-Type'] = 'application/json'
      headers[:'Cko-Idempotency-Key'] = idempotency_key unless idempotency_key.nil?

      apply_extra_headers(headers, extra_headers)

      json_body = CheckoutSdk::JsonSerializer.to_custom_hash(body).to_json

      begin
        @log.info "#{method}: /#{path}"
        response = @client.run_request(method, path, json_body, headers)
      rescue Faraday::ClientError => e
        raise CheckoutApiException, e.response
      end

      parse_response(response)
    end

    def default_headers(authorization)
      { 'User-Agent': "checkout-sdk-ruby/#{VERSION}", Accept: 'application/json',
        Authorization: authorization.authorization_header }
    end

    # Attribute name to HTTP header name, for every typed headers container the SDK supports.
    #
    # The header names are case sensitive in the spec: return-encrypted-cvv is lower case where a
    # naive conversion would produce Return-Encrypted-Cvv.
    #
    # The values are Strings, not Symbols, and that is load bearing. Faraday::Utils::Headers
    # preserves a String key verbatim but rewrites a Symbol key as
    # `key.to_s.split('_').map(&:capitalize).join('-')`, so :'return-encrypted-cvv' would reach
    # the wire as Return-encrypted-cvv and :'Encryption-Key' as Encryption-key. Strings are the
    # only way to send the spelling the spec asks for. As a side effect this also stops If-Match
    # being sent as If-match, which it was before.
    EXTRA_HEADER_NAMES = {
      if_match: 'If-Match',
      accept: 'Accept',
      return_encrypted_cvv: 'return-encrypted-cvv',
      encryption_key: 'Encryption-Key'
    }.freeze
    private_constant :EXTRA_HEADER_NAMES

    # Map a typed headers container (e.g. {CheckoutSdk::Common::Headers},
    # {CheckoutSdk::Issuing::CardUpdateHeaders}) onto the underlying HTTP header hash. Each
    # attribute that is set is emitted as the corresponding HTTP header.
    #
    # Previously a hand-written if/return chain. That shape had a latent trap: it ended with
    # `return unless extra_headers.respond_to?(:accept) && extra_headers.accept`, so any header
    # handled after that point was dead code for every container without an `accept` attribute.
    # Iterating an explicit map removes the trap and keeps the existing If-Match and Accept
    # behaviour byte for byte.
    def apply_extra_headers(http_headers, extra_headers)
      return if extra_headers.nil?

      EXTRA_HEADER_NAMES.each do |attribute, header_name|
        next unless extra_headers.respond_to?(attribute)

        value = extra_headers.public_send(attribute)
        next if value.nil? || value.to_s.empty?

        http_headers[header_name] = value
      end
    end

    def append_params(path, input_params)
      raise CheckoutArgumentException, 'Query parameters were not provided' if input_params.nil?

      params = if input_params.is_a? String
                 input_params
               else
                 hash = CheckoutSdk::JsonSerializer.to_custom_hash(input_params)
                 URI.encode_www_form(hash)
               end

      "#{path}?#{params}"
    end

    def build_multipart_request(file_request, file)
      key = file_request.class.name.start_with?(CheckoutSdk::Common::FileRequest.name) ? :file : :path
      {
        key => Faraday::Multipart::FilePart.new(
          file,
          MIME::Types.type_for(file_request.file).first,
          File.basename(file_request.file)
        ),
        purpose: file_request.purpose
      }
    end

    def upload(path, authorization, file_request)
      headers = default_headers(authorization)

      File.open(file_request.file) do |file|
        form = build_multipart_request(file_request, file)

        begin
          @log.info "post: /#{path}"
          response = @multipart_client.run_request(:post, path, form, headers)
        rescue Faraday::ClientError => e
          raise CheckoutApiException, e.response
        end

        parse_response(response)
      end
    end

    def parse_response(response)
      raise CheckoutApiException, response if response.status < 200 || response.status >= 400

      metadata = CheckoutUtils.map_to_http_metadata(response)
      body = parse_body(response)

      if body.is_a?(Array)
        body = OpenStruct.new(items: body)
      elsif !body.is_a?(OpenStruct)
        body = OpenStruct.new(contents: body)
      end

      body.http_metadata = metadata if body.is_a?(OpenStruct)

      body
    rescue JSON::ParserError => e
      raise CheckoutApiException.new(response, "Error parsing JSON: #{e.message}")
    rescue StandardError => e
      @log&.error("Unexpected error occurred: #{e.message}")
      raise
    end

    def parse_body(response)
      content_type = response.headers['Content-Type']
      return OpenStruct.new if response.body.nil? || response.body.empty?

      if content_type&.include?('application/json')
        parsed_value = JSON.parse(response.body)
        deep_convert_to_ostruct(parsed_value)
      elsif content_type&.include?('text/csv')
        csv_data = CSV.parse(response.body, headers: true)
        OpenStruct.new(csv: csv_data)
      else
        OpenStruct.new(contents: response.body)
      end
    end

    def deep_convert_to_ostruct(obj)
      case obj
      when Hash
        OpenStruct.new(obj.transform_values { |value| deep_convert_to_ostruct(value) })
      when Array
        obj.map { |item| deep_convert_to_ostruct(item) }
      else
        obj
      end
    end
  end
end
