# frozen_string_literal: true

module CheckoutSdk
  class ApiClient
    # @param [CheckoutConfiguration] _configuration
    # @param [String] uri
    def initialize(_configuration, uri)
      # TODO: expect given http client
      @client = build_default_client(uri)
      @multipart_client = build_multipart_client(uri)
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
      upload_file(path, authorization, request)
    end

    private

    def build_multipart_client(uri)
      Faraday.new(uri) do |f|
        f.request :multipart
        f.response :raise_error
      end
    end

    def build_default_client(uri)
      Faraday.new(uri) do |f|
        f.response :raise_error
      end
    end

    def invoke(method, path, authorization, body = nil, idempotency_key = nil, params: nil)
      path = append_params(path, params) unless params.nil?

      headers = get_default_headers authorization
      headers[:'Content-Type'] = 'application/json'
      headers[:'Cko-Idempotency-Key'] = idempotency_key unless idempotency_key.nil?

      json_body = CheckoutSdk::JsonSerializer.to_custom_hash(body).to_json

      begin
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
      # TODO: refactor this into a utils method
      hash = CheckoutSdk::JsonSerializer.to_custom_hash(input_params)
      params = URI.encode_www_form(hash)
      "#{path}?#{params}"
    end

    def build_multipart_request(file_request, file)
      key = file_request.is_a?(CheckoutSdk::Common::FileRequest) ? :file : :path
      {
        key => Faraday::Multipart::FilePart.new(
          file,
          MIME::Types.type_for(file_request.file).first,
          File.basename(file_request.file)
        ),
        :purpose => file_request.purpose
      }
    end

    def upload_file(path, authorization, file_request)
      headers = get_default_headers authorization

      file = File.open(file_request.file)

      form = build_multipart_request file_request, file

      begin
        response = @multipart_client.run_request(:post, path, form, headers)
      rescue Faraday::ClientError => e
        raise CheckoutApiException, e.response
      ensure
        file.close
      end

      parse_response response
    end

    def parse_response(response)
      # TODO: include http metadata response
      JSON.parse(response.body, object_class: OpenStruct) if !response.body.nil? && response.body != ''
    end
  end
end
