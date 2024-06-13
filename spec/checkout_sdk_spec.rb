# frozen_string_literal: true

RSpec.describe CheckoutSdk do
  context 'it has some properties' do
    it 'should has a version number' do
      expect(CheckoutSdk::VERSION).not_to be nil
    end
  end

  describe 'default_sdk' do
    context 'when building default sdk with correct parameters' do
      it 'builds default sdk with both keys' do
        default_sdk = CheckoutSdk.builder
                                 .static_keys
                                 .with_secret_key(ENV['CHECKOUT_DEFAULT_SECRET_KEY'])
                                 .with_public_key(ENV['CHECKOUT_DEFAULT_PUBLIC_KEY'])
                                 .with_environment(CheckoutSdk::Environment.production)
                                 .build
        expect(default_sdk.class).to eq(CheckoutSdk::CheckoutApi)
      end

      it 'builds default sdk with both keys with subdomain' do
        default_sdk = CheckoutSdk.builder
                                 .static_keys
                                 .with_secret_key(ENV['CHECKOUT_DEFAULT_SECRET_KEY'])
                                 .with_public_key(ENV['CHECKOUT_DEFAULT_PUBLIC_KEY'])
                                 .with_environment(CheckoutSdk::Environment.production)
                                 .with_environment_subdomain('12345domain')
                                 .build
        expect(default_sdk.class).to eq(CheckoutSdk::CheckoutApi)
      end

      it 'builds default sdk with secret key only' do
        default_sdk = CheckoutSdk.builder
                                 .static_keys
                                 .with_secret_key(ENV['CHECKOUT_DEFAULT_SECRET_KEY'])
                                 .with_environment(CheckoutSdk::Environment.production)
                                 .build
        expect(default_sdk.class).to eq(CheckoutSdk::CheckoutApi)
      end

      it 'builds default sdk with secret key only with subdomain' do
        default_sdk = CheckoutSdk.builder
                                 .static_keys
                                 .with_secret_key(ENV['CHECKOUT_DEFAULT_SECRET_KEY'])
                                 .with_environment(CheckoutSdk::Environment.production)
                                 .with_environment_subdomain('12345domain')
                                 .build
        expect(default_sdk.class).to eq(CheckoutSdk::CheckoutApi)
      end
    end

    context 'when building default sdk with incorrect parameters' do
      it 'raises an error when secret key is invalid' do
        expect do
          CheckoutSdk.builder
                     .static_keys
                     .with_secret_key('my wrong key')
                     .with_environment(CheckoutSdk::Environment.production)
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException)
      end

      it 'raises an error when public key is invalid' do
        expect do
          CheckoutSdk.builder
                     .static_keys
                     .with_secret_key(ENV['CHECKOUT_DEFAULT_SECRET_KEY'])
                     .with_public_key('my wrong key')
                     .with_environment(CheckoutSdk::Environment.production)
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException)
      end
    end
  end

  describe 'oauth sdk' do
    context 'when building oauth sdk with correct parameters' do
      it 'should build oauth sdk with default http client correctly' do
        oauth_sdk = CheckoutSdk.builder
                               .oauth
                               .with_client_credentials(ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_ID'],
                                                        ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_SECRET'])
                               .with_authorization_uri(CheckoutSdk::Environment.sandbox.authorization_uri)
                               .with_scopes([CheckoutSdk::OAuthScopes::VAULT,
                                             CheckoutSdk::OAuthScopes::GATEWAY])
                               .with_environment(CheckoutSdk::Environment.sandbox)
                               .build

        expect(oauth_sdk.class).to eq(CheckoutSdk::CheckoutApi)
      end

      it 'should build oauth sdk with default http client correctly with subdomain' do
        oauth_sdk = CheckoutSdk.builder
                               .oauth
                               .with_client_credentials(ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_ID'],
                                                        ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_SECRET'])
                               .with_authorization_uri(CheckoutSdk::Environment.sandbox.authorization_uri)
                               .with_scopes([CheckoutSdk::OAuthScopes::VAULT,
                                             CheckoutSdk::OAuthScopes::GATEWAY])
                               .with_environment(CheckoutSdk::Environment.sandbox)
                               .with_environment_subdomain('12345domain')
                               .build

        expect(oauth_sdk.class).to eq(CheckoutSdk::CheckoutApi)
      end

      it 'should build oauth sdk with custom http client correctly' do
        http_client = Faraday.new(CheckoutSdk::Environment.sandbox.base_uri) do |f|
          f.response(:raise_error)
        end

        oauth_sdk = CheckoutSdk.builder
                               .oauth
                               .with_client_credentials(ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_ID'],
                                                        ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_SECRET'])
                               .with_authorization_uri(CheckoutSdk::Environment.sandbox.authorization_uri)
                               .with_scopes([CheckoutSdk::OAuthScopes::VAULT,
                                             CheckoutSdk::OAuthScopes::GATEWAY])
                               .with_environment(CheckoutSdk::Environment.sandbox)
                               .with_http_client(http_client)
                               .build

        expect(oauth_sdk.class).to eq(CheckoutSdk::CheckoutApi)
      end
    end

    context 'when building oauth sdk with incorrect parameters' do
      it 'raises an error when client_id is invalid' do
        expect do
          CheckoutSdk.builder
                     .oauth
                     .with_client_credentials(nil,
                                              ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_SECRET'])
                     .with_authorization_uri(CheckoutSdk::Environment.sandbox.authorization_uri)
                     .with_scopes([CheckoutSdk::OAuthScopes::VAULT,
                                   CheckoutSdk::OAuthScopes::GATEWAY])
                     .with_environment(CheckoutSdk::Environment.sandbox)
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException,
                           'Invalid OAuth "client_id" or "client_secret"')
      end

      it 'raises an error when client_secret is invalid' do
        expect do
          CheckoutSdk.builder
                     .oauth
                     .with_client_credentials(ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_ID'],
                                              nil)
                     .with_authorization_uri(CheckoutSdk::Environment.sandbox.authorization_uri)
                     .with_scopes([CheckoutSdk::OAuthScopes::VAULT,
                                   CheckoutSdk::OAuthScopes::GATEWAY])
                     .with_environment(CheckoutSdk::Environment.sandbox)
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException,
                           'Invalid OAuth "client_id" or "client_secret"')
      end

      it 'raises an error when the authorization_uri provided is invalid' do
        expect do
          CheckoutSdk.builder
                     .oauth
                     .with_client_credentials(ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_ID'],
                                              ENV['CHECKOUT_DEFAULT_OAUTH_CLIENT_SECRET'])
                     .with_scopes([CheckoutSdk::OAuthScopes::VAULT,
                                   CheckoutSdk::OAuthScopes::GATEWAY])
                     .with_authorization_uri('https://invalid.checkout.com/')
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException)
      end
    end
  end

  describe 'previous sdk' do
    context 'when building previous sdk with correct parameters' do
      it 'builds previous sdk with both keys' do
        default_sdk = CheckoutSdk.builder
                                 .previous
                                 .static_keys
                                 .with_secret_key(ENV['CHECKOUT_PREVIOUS_SECRET_KEY'])
                                 .with_public_key(ENV['CHECKOUT_PREVIOUS_PUBLIC_KEY'])
                                 .with_environment(CheckoutSdk::Environment.production)
                                 .build
        expect(default_sdk.class).to eq(CheckoutSdk::Previous::CheckoutApi)
      end

      it 'builds previous sdk with both keys with subdomain' do
        default_sdk = CheckoutSdk.builder
                                 .previous
                                 .static_keys
                                 .with_secret_key(ENV['CHECKOUT_PREVIOUS_SECRET_KEY'])
                                 .with_public_key(ENV['CHECKOUT_PREVIOUS_PUBLIC_KEY'])
                                 .with_environment(CheckoutSdk::Environment.production)
                                 .with_environment_subdomain('12345domain')
                                 .build
        expect(default_sdk.class).to eq(CheckoutSdk::Previous::CheckoutApi)
      end

      it 'builds previous sdk with secret key only' do
        default_sdk = CheckoutSdk.builder
                                 .previous
                                 .static_keys
                                 .with_secret_key(ENV['CHECKOUT_PREVIOUS_SECRET_KEY'])
                                 .with_environment(CheckoutSdk::Environment.production)
                                 .build
        expect(default_sdk.class).to eq(CheckoutSdk::Previous::CheckoutApi)
      end
    end

    context 'when building previous sdk with incorrect parameters' do
      it 'raises an error when secret key is invalid' do
        expect do
          CheckoutSdk.builder
                     .previous
                     .static_keys
                     .with_secret_key('my wrong key')
                     .with_environment(CheckoutSdk::Environment.production)
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException)
      end

      it 'raises an error when public key is invalid' do
        expect do
          CheckoutSdk.builder
                     .previous
                     .static_keys
                     .with_secret_key(ENV['CHECKOUT_PREVIOUS_SECRET_KEY'])
                     .with_public_key('my wrong key')
                     .with_environment(CheckoutSdk::Environment.production)
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException)
      end
    end
  end
end
