# frozen_string_literal: true

module CheckoutSdk
  # @!attribute base_uri
  #   @return [String]
  # @!attribute authorization_uri
  #   @return [String]
  # @!attribute files_uri
  #   @return [String]
  # @!attribute transfers_uri
  #   @return [String]
  # @!attribute balances_uri
  #   @return [String]
  # @!attribute is_sandbox
  #   @return [String]
  class Environment
    attr_reader :base_uri,
                :authorization_uri,
                :files_uri,
                :transfers_uri,
                :balances_uri,
                :is_sandbox

    # @param [String] base_uri
    # @param [String] authorization_uri
    # @param [String] files_uri
    # @param [String] transfers_uri
    # @param [String] balances_uri
    # @param [TrueClass, FalseClass] is_sandbox
    def initialize(base_uri, authorization_uri, files_uri, transfers_uri, balances_uri, is_sandbox)
      @base_uri = base_uri
      @authorization_uri = authorization_uri
      @files_uri = files_uri
      @transfers_uri = transfers_uri
      @balances_uri = balances_uri
      @is_sandbox = is_sandbox
    end

    # @return [CheckoutSdk::Environment]
    def self.sandbox
      Environment.new('https://api.sandbox.checkout.com/',
                      'https://access.sandbox.checkout.com/connect/token',
                      'https://files.sandbox.checkout.com/',
                      'https://transfers.sandbox.checkout.com/',
                      'https://balances.sandbox.checkout.com/',
                      true)
    end

    # @return [CheckoutSdk::Environment]
    def self.production
      Environment.new('https://api.checkout.com/',
                      'https://access.checkout.com/connect/token',
                      'https://files.checkout.com/',
                      'https://transfers.checkout.com/',
                      'https://balances.checkout.com/',
                      false)
    end
  end
end
