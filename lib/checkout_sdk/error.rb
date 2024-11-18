# frozen_string_literal: true

module CheckoutSdk
  class CheckoutException < StandardError; end

  class CheckoutArgumentException < CheckoutException; end

  class CheckoutAuthorizationException < CheckoutException
    def self.invalid_authorization(authorization_type)
      new("Operation requires #{authorization_type} authorization type.")
    end

    def self.invalid_key(key_type)
      new("#{key_type} is required for this operation.")
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
      message = "The API response status code (#{http_metadata.status_code}) does not indicate success."
      if @error_details && !@error_details.to_h.empty?
        details = @error_details.to_h.map { |key, value| "#{key}: #{value}" }.join(', ')
        message += " Details: #{details}."
      end
      message
    end
  end
end
