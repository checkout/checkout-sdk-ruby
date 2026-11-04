# frozen_string_literal: true

module CheckoutSdk
  class CheckoutException < StandardError; end

  class CheckoutArgumentException < CheckoutException; end

  class CheckoutAuthorizationException < CheckoutException
    # @return [CheckoutSdk::HttpMetadata, nil] response status, headers and body when raised for an OAuth token response
    attr_reader :http_metadata

    def self.invalid_authorization(authorization_type)
      new("Operation requires #{authorization_type} authorization type.")
    end

    def self.invalid_key(key_type)
      new("#{key_type} is required for this operation.")
    end

    # Builds the error for an unsuccessful OAuth token response from the response data only.
    #
    # @param [Integer, nil] status
    # @param [Hash, nil] headers
    # @param [String, nil] body
    # @return [CheckoutSdk::CheckoutAuthorizationException]
    def self.token_request_failed(status, headers, body)
      http_metadata = CheckoutSdk::HttpMetadata.new
      http_metadata.status_code = status
      http_metadata.headers = headers
      http_metadata.body = body

      error = new(token_error_message(status, body))
      error.instance_variable_set(:@http_metadata, http_metadata)
      error
    end

    def self.token_error_message(status, body)
      message = "The OAuth token response status code (#{status}) does not indicate success."
      return message if body.nil? || body.to_s.strip.empty?

      parsed = parse_json(body)
      details = parsed.is_a?(Hash) ? parsed.map { |key, value| "#{key}: #{value}" }.join(', ') : body.to_s.strip
      "#{message} Details: #{details}."
    end

    def self.parse_json(body)
      JSON.parse(body)
    rescue JSON::ParserError, TypeError
      nil
    end
    private_class_method :parse_json
    private_class_method :token_error_message
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
      message = "The API response status code (#{http_metadata.status_code}) does not indicate success."
      if @error_details && !@error_details.to_h.empty?
        details = @error_details.to_h.map { |key, value| "#{key}: #{value}" }.join(', ')
        message += " Details: #{details}."
      end
      message
    end
  end
end
