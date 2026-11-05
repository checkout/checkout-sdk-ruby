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

    MAX_MESSAGE_DETAILS_LENGTH = 256
    private_constant :MAX_MESSAGE_DETAILS_LENGTH

    # Returns the request path in a form safe for a single log line: the query string is left out
    # and control characters are escaped.
    #
    # @param [String, nil] path
    # @return [String]
    def self.loggable_path(path)
      escape_control_characters(utf8_text(path).split('?', 2).first.to_s)
    end

    # Builds an exception message from a prefix and a response body. A JSON object body adds its
    # "key: value" pairs as details; any other non-empty body is added as is only when
    # include_text_body is true. Details are shortened and their control characters escaped.
    #
    # @param [String] prefix
    # @param [String, nil] body
    # @param [Boolean] include_text_body
    # @return [String]
    def self.error_message(prefix, body, include_text_body: false)
      text = utf8_text(body).strip
      parsed = json_object(text)
      details = parsed&.map { |key, value| "#{key}: #{value}" }&.join(', ')
      details = text if details.nil? && include_text_body
      return prefix if details.nil? || details.empty?

      details = "#{details[0, MAX_MESSAGE_DETAILS_LENGTH]}..." if details.length > MAX_MESSAGE_DETAILS_LENGTH
      "#{prefix} Details: #{escape_control_characters(details)}."
    end

    INVALID_PATH_SEGMENTS = ['', '.', '..'].freeze
    FORBIDDEN_PATH_SEGMENT_BYTES = %r{[/\\\x00-\x1F\x7F]}n.freeze
    INVALID_PATH_SEGMENT_MESSAGE = "Invalid path segment: it must be valid text, not nil, empty, '.' or '..', " \
                                   "and must not contain '/', '\\' or ASCII control characters"
    private_constant :INVALID_PATH_SEGMENTS, :FORBIDDEN_PATH_SEGMENT_BYTES, :INVALID_PATH_SEGMENT_MESSAGE

    # Encodes a value as one RFC 3986 path segment. The value is converted to UTF-8 and every byte
    # outside the unreserved set (A-Z, a-z, 0-9, "-", ".", "_", "~") is percent-encoded, so the value
    # always stays a single segment of the request path. The checks run on the converted text.
    #
    # @param [String, Symbol, Integer] value
    # @return [String]
    # @raise [CheckoutArgumentException] when the value is nil, empty, "." or "..", cannot be converted
    #   to valid UTF-8, contains "/", "\" or an ASCII control character (U+0000 to U+001F, U+007F), or
    #   its to_s does not return a String
    def self.encode_path_segment(value)
      text = value.nil? ? '' : value.to_s
      raise CheckoutArgumentException, INVALID_PATH_SEGMENT_MESSAGE unless text.is_a?(String)

      bytes = to_valid_utf8(text)&.b
      if bytes.nil? || FORBIDDEN_PATH_SEGMENT_BYTES.match?(bytes)
        raise CheckoutArgumentException, INVALID_PATH_SEGMENT_MESSAGE
      end

      encoded = bytes.gsub(/[^A-Za-z0-9\-._~]/n) { |byte| format('%%%02X', byte.ord) }
                     .force_encoding(Encoding::UTF_8)
      raise CheckoutArgumentException, INVALID_PATH_SEGMENT_MESSAGE if INVALID_PATH_SEGMENTS.include?(encoded)

      encoded
    end

    # Returns a copy of the Faraday error, of the same class and with the same backtrace and wrapped
    # exception, that keeps only the response status, headers and body and whose message names the
    # method and URL without the query string. Errors without a response are returned unchanged.
    #
    # @param [Faraday::Error] error
    # @return [Faraday::Error]
    def self.without_request_data(error)
      return error if error.response.nil?

      metadata = map_to_http_metadata(error.response)
      rebuilt = error.exception(response_error_message(metadata.status_code, error.response))
      rebuilt.instance_variable_set(:@response,
                                    { status: metadata.status_code, headers: metadata.headers, body: metadata.body })
      rebuilt
    end

    def self.response_error_message(status, response)
      message = "the server responded with status #{status}"
      request = response.is_a?(Hash) ? response[:request] : nil
      return message unless request.is_a?(Hash) && request[:url]

      "#{message} for #{request[:method].to_s.upcase} #{loggable_path(request[:url].to_s)}"
    end
    private_class_method :response_error_message

    def self.json_object(text)
      parsed = JSON.parse(text)
      parsed.is_a?(Hash) ? parsed : nil
    rescue JSON::ParserError
      nil
    end
    private_class_method :json_object

    # Escapes control characters and Unicode line and paragraph separators in UTF-8 text.
    def self.escape_control_characters(text)
      text.gsub(/[[:cntrl:]\p{Zl}\p{Zp}]/) { |char| char.dump[1..-2] }
    end
    private_class_method :escape_control_characters

    # Converts text to UTF-8, transcoding from its own encoding. Returns nil when the text cannot be
    # converted or the result is not valid UTF-8.
    def self.to_valid_utf8(text)
      converted = text.encode(Encoding::UTF_8)
      converted.valid_encoding? ? converted : nil
    rescue EncodingError
      nil
    end
    private_class_method :to_valid_utf8

    # Lenient form of to_valid_utf8 for log and message text: bytes that cannot be converted are read
    # as UTF-8 and invalid sequences are replaced.
    def self.utf8_text(text)
      text = text.to_s
      (to_valid_utf8(text) || text.dup.force_encoding(Encoding::UTF_8)).scrub
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
