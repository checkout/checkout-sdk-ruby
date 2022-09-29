# frozen_string_literal: true

module CheckoutSdk
  # @!attribute token
  #   @return [String]
  # @!attribute expiration_date
  #   @return [Time]
  class OAuthAccessToken
    attr_accessor :token,
                  :expiration_date

    # @param [String] token
    # @param [Time] expiration_date
    # @return [OAuthAccessToken]
    def initialize(token, expiration_date)
      @token = token
      @expiration_date = expiration_date
    end

    # @return [TrueClass, FalseClass]
    def valid?
      return false if @token.nil?

      @expiration_date > Time.now
    end
  end
end
