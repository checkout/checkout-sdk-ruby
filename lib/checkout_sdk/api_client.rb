# frozen_string_literal: true

module CheckoutSdk
  class ApiClient
    attr_accessor :client, :multipart_client, :log

    # @param [CheckoutConfiguration] configuration
    # @param [String] uri
    def initialize(configuration, uri)
      @client = configuration.http_client.clone
      @client.url_prefix = uri
      @multipart_client = configuration.multipart_http_client.clone
      @multipart_client.url_prefix = uri
      @log = configuration.logger
    end

    # @param [String] path
    # @param [SdkAuthorization] authorization
    # @param [Object] params
    def invoke_get(path,
                   authorization,
                   params = nil)
      invoke(:get, path, authorization, params: params)
    end

    def invoke_post(path,
                    authorization,
                    request = nil,
                    idempotency_key = nil)
      invoke(:post, path, authorization, request, idempotency_key)
    end

    def invoke_put(path,
                   authorization,
                   request)
      invoke(:put, path, authorization, request)
    end

    def invoke_patch(path,
                     authorization,
                     request = nil)
      invoke(:patch, path, authorization, request)
    end

    def invoke_delete(path,
                      authorization)
      invoke(:delete, path, authorization)
    end

    def submit_file(path,
                    authorization,
                    request)
      upload(path, authorization, request)
    end

    private

    def invoke(method, path, authorization, body = nil, idempotency_key = nil, params: nil)
      path = append_params(path, params) unless params.nil?

      headers = get_default_headers authorization
      headers[:'Content-Type'] = 'application/json'
      headers[:'Cko-Idempotency-Key'] = idempotency_key unless idempotency_key.nil?

      json_body = CheckoutSdk::JsonSerializer.to_custom_hash(body).to_json

      begin
        @log.info "#{method}: /#{path}"
        response = @client.run_request(method, path, json_body, headers)
      rescue Faraday::ClientError => e
        raise CheckoutApiException, e.response
      end

      parse_response response
    end

    def get_default_headers(authorization)
      {
        'User-Agent': "checkout-sdk-ruby/#{VERSION}",
        Accept: 'application/json',
        Authorization: authorization.authorization_header
      }
    end

    def append_params(path, input_params)
      raise CheckoutArgumentException, 'Query parameters were not provided' if input_params.nil?

      if input_params.is_a? String
        params = input_params
      else
        hash = CheckoutSdk::JsonSerializer.to_custom_hash(input_params)
        params = URI.encode_www_form(hash)
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
        :purpose => file_request.purpose
      }
    end

    def upload(path, authorization, file_request)
      headers = get_default_headers authorization

      file = File.open(file_request.file)

      form = build_multipart_request file_request, file

      begin
        @log.info "post: /#{path}"
        response = @multipart_client.run_request(:post, path, form, headers)
      rescue Faraday::ClientError => e
        raise CheckoutApiException, e.response
      ensure
        file.close
      end

      parse_response response
    end

    def parse_response(response)
      raise CheckoutApiException, response if response.status < 200 || response.status >= 300

      metadata = CheckoutUtils.map_to_http_metadata(response)
      body = parse_json_or_contents(response)
      body = OpenStruct.new if body.nil?
      body = OpenStruct.new(items: body) if body.is_a? Array
      body.metadata = metadata if body.is_a? OpenStruct
      body
    end

    def parse_json_or_contents(response)
      return if response.body.nil? || response.body == ''

      if response.body.start_with?('{', '[')
        JSON.parse(response.body, object_class: OpenStruct)
      else
        OpenStruct.new(contents: response.body)
      end
    end
  end
end
