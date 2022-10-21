# frozen_string_literal: true

module Helpers
  module SandboxTestFixture
    attr_reader :oauth_sdk

    # @return [CheckoutSdk::CheckoutApi]
    def default_sdk
      CheckoutSdk.builder
                 .static_keys
                 .with_secret_key(ENV['CHECKOUT_DEFAULT_SECRET_KEY'])
                 .with_public_key(ENV['CHECKOUT_DEFAULT_PUBLIC_KEY'])
                 .with_environment(CheckoutSdk::Environment.sandbox)
                 .build
    end

    def previous_sdk
      CheckoutSdk.builder
                 .previous
                 .static_keys
                 .with_secret_key(ENV['CHECKOUT_PREVIOUS_SECRET_KEY'])
                 .with_public_key(ENV['CHECKOUT_PREVIOUS_PUBLIC_KEY'])
                 .with_environment(CheckoutSdk::Environment.sandbox)
                 .build
    end

    def oauth_sdk
      if @oauth_sdk.nil?
        @oauth_sdk = CheckoutSdk.builder
                                .oauth
                                .with_client_credentials(
                                  ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_ID'],
                                  ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_SECRET'])
                                .with_scopes(get_oauth_scopes)
                                .with_environment(CheckoutSdk::Environment.sandbox)
                                .build
      end
      @oauth_sdk
    end

    def retriable(callback, predicate = nil)
      current_attempt = 1
      max_attempts = 10
      while current_attempt <= max_attempts
        begin
          response = callback.call
          return response if predicate.nil?
          return response if predicate.call(response)
        rescue CheckoutSdk::CheckoutApiException => e
          sleep 2
        end
        current_attempt += 1
      end
    end

    def assert_response(response, properties = nil)
      expect(response).not_to be nil
      properties&.each do |evaluation|
          assert_response_validation(response, evaluation)
        end
    end

    def new_idempotency_key
      "ik-#{SecureRandom.uuid}"
    end

    private

    def assert_response_validation(response, properties)
      if properties.include? '.'
        # "a.b.c" to "a","b","c"
        props = properties.split('.')
        # value['a']
        nested_object = response[props[0].to_sym]
        # collect to 'b.c'
        joined = props.drop(1).join('.')
        assert_response_validation(nested_object, joined)
      else
        expect(response[properties.to_sym]).not_to be nil
      end
    end

    def get_oauth_scopes
      [CheckoutSdk::OAuthScopes::VAULT, CheckoutSdk::OAuthScopes::GATEWAY,
       CheckoutSdk::OAuthScopes::PAYOUTS_BANK_DETAILS, CheckoutSdk::OAuthScopes::DISPUTES,
       CheckoutSdk::OAuthScopes::SESSIONS_APP, CheckoutSdk::OAuthScopes::SESSIONS_BROWSER,
       CheckoutSdk::OAuthScopes::FLOW, CheckoutSdk::OAuthScopes::FILES,
       CheckoutSdk::OAuthScopes::FX, CheckoutSdk::OAuthScopes::BALANCES_VIEW,
       CheckoutSdk::OAuthScopes::MARKETPLACE, CheckoutSdk::OAuthScopes::TRANSFERS,
       CheckoutSdk::OAuthScopes::REPORTING]
    end
  end
end
