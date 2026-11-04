# frozen_string_literal: true

module CheckoutSdk
  class CheckoutUtils
    # @return [CheckoutSdk::HttpMetadata]
    def self.map_to_http_metadata(response)
      http_metadata = CheckoutSdk::HttpMetadata.new
      return http_metadata if response.nil?

      if response.is_a?(Hash)
        http_metadata.headers = response[:headers]
        http_metadata.status_code = response[:status]
        http_metadata.body = response[:body]
      end

      if response.class.name.start_with? Faraday::Response.name
        http_metadata.headers = response.headers
        http_metadata.status_code = response.status
        http_metadata.body = response.body
      end
      http_metadata
    end

    MAX_MESSAGE_BODY_LENGTH = 256
    private_constant :MAX_MESSAGE_BODY_LENGTH

    # Returns the text in a form safe for a single log line: control characters and Unicode line
    # and paragraph separators are escaped, invalid byte sequences are replaced.
    #
    # @param [String, nil] text
    # @return [String]
    def self.escape_control_characters(text)
      utf8_text(text).gsub(/[[:cntrl:]\p{Zl}\p{Zp}]/) { |char| char.dump[1..-2] }
    end

    # Returns the request path in a form safe for a single log line: the query string is left out
    # and control characters are escaped.
    #
    # @param [String, nil] path
    # @return [String]
    def self.loggable_path(path)
      escape_control_characters(utf8_text(path).split('?', 2).first)
    end

    # Formats error details as "key: value" pairs for an exception message.
    #
    # @param [Hash] details
    # @return [String]
    def self.format_error_details(details)
      escape_control_characters(details.map { |key, value| "#{key}: #{value}" }.join(', '))
    end

    # Shortens a response body for an exception message and escapes its control characters.
    #
    # @param [String, nil] body
    # @return [String]
    def self.message_body(body)
      text = utf8_text(body).strip
      text = "#{text[0, MAX_MESSAGE_BODY_LENGTH]}..." if text.length > MAX_MESSAGE_BODY_LENGTH
      escape_control_characters(text)
    end

    # Returns a Faraday error that keeps the class, the response status, headers and body and the
    # backtrace of the given error, without the request data and with a message that names the
    # method and URL without the query string. Errors without a response are returned unchanged.
    #
    # @param [Faraday::Error] error
    # @return [Faraday::Error]
    def self.without_request_data(error)
      return error if error.response.nil?

      metadata = map_to_http_metadata(error.response)
      response = { status: metadata.status_code, headers: metadata.headers, body: metadata.body }
      message = response_error_message(metadata.status_code, error.response)
      rebuilt = begin
        error.class.new(message, response)
      rescue StandardError
        Faraday::Error.new(message, response)
      end
      rebuilt.set_backtrace(error.backtrace)
      rebuilt
    end

    def self.response_error_message(status, response)
      message = "the server responded with status #{status}"
      request = response.is_a?(Hash) ? response[:request] : nil
      return message unless request.is_a?(Hash) && request[:url]

      "#{message} for #{request[:method].to_s.upcase} #{loggable_path(request[:url].to_s)}"
    end
    private_class_method :response_error_message

    def self.utf8_text(text)
      text.to_s.dup.force_encoding(Encoding::UTF_8).scrub
    end
    private_class_method :utf8_text

    # @return [Faraday::Connection]
    def self.build_multipart_client
      Faraday.new do |f|
        f.request :multipart
        f.response :raise_error, include_request: false
      end
    end

    # @return [Faraday::Connection]
    def self.build_default_client
      Faraday.new do |f|
        f.response :follow_redirects
        f.response :raise_error, include_request: false
      end
    end
  end
end
