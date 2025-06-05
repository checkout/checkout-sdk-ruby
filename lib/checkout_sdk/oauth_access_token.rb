# frozen_string_literal: true

module CheckoutSdk
  # @!attribute token
  #   @return [String]
  # @!attribute token_type
  #   @return [String]
  # @!attribute expiration_date
  #   @return [Time]
  class OAuthAccessToken
    attr_accessor :token,
                  :token_type,
                  :expiration_date

    # @param [String] token
    # @param [String] token_type
    # @param [Time] expiration_date
    # @return [OAuthAccessToken]
    def initialize(token, token_type, expiration_date)
      @token = token
      @token_type = token_type
      @expiration_date = expiration_date
    end

    # @return [TrueClass, FalseClass]
    def valid?
      return false if @token.nil?

      @expiration_date > Time.now
    end
  end
end
