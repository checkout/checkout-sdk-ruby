# frozen_string_literal: true

module CheckoutSdk
  class CheckoutException < StandardError; end

  class CheckoutArgumentException < CheckoutException; end

  class CheckoutAuthorizationException < CheckoutException
    # @return [CheckoutSdk::HttpMetadata, nil] response status, headers and body when raised for an OAuth token response
    attr_reader :http_metadata

    # @param [String, nil] message
    # @param [CheckoutSdk::HttpMetadata, nil] http_metadata
    def initialize(message = nil, http_metadata = nil)
      @http_metadata = http_metadata
      super(message)
    end

    def self.invalid_authorization(authorization_type)
      new("Operation requires #{authorization_type} authorization type.")
    end

    def self.invalid_key(key_type)
      new("#{key_type} is required for this operation.")
    end

    # Builds the error for an unsuccessful OAuth token response from the response data only.
    #
    # @param [CheckoutSdk::HttpMetadata] http_metadata
    # @return [CheckoutSdk::CheckoutAuthorizationException]
    def self.token_request_failed(http_metadata)
      prefix = "The OAuth token response status code (#{http_metadata.status_code}) does not indicate success."
      new(CheckoutUtils.error_message(prefix, http_metadata.body, include_text_body: true), http_metadata)
    end

    # Builds the error for an OAuth token request that failed without a response.
    #
    # @return [CheckoutSdk::CheckoutAuthorizationException]
    def self.token_request_without_response
      new('The OAuth token request failed without a response.')
    end
  end

  class CheckoutApiException < CheckoutException
    attr_reader :http_metadata, :error_details

    def initialize(response, message = nil)
      @http_metadata = CheckoutUtils.map_to_http_metadata(response)
      @error_details = parse_error_details(http_metadata.body)
      super(message || build_error_message)
    end

    private

    def parse_error_details(body)
      return if body.nil? || body.empty?

      JSON.parse(body, object_class: OpenStruct)
    rescue JSON::ParserError
      nil
    end

    def build_error_message
      prefix = "The API response status code (#{http_metadata.status_code}) does not indicate success."
      CheckoutUtils.error_message(prefix, http_metadata.body)
    end
  end
end
