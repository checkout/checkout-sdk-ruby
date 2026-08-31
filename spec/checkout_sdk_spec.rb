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
                                 .with_environment_subdomain('12345domain')
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
                                 .with_environment_subdomain('12345domain')
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

      it 'builds default sdk with the legacy domain opt-out' do
        default_sdk = CheckoutSdk.builder
                                 .static_keys
                                 .with_secret_key(ENV.fetch('CHECKOUT_DEFAULT_SECRET_KEY', nil))
                                 .with_environment(CheckoutSdk::Environment.production)
                                 .with_legacy_domain
                                 .build
        expect(default_sdk.class).to eq(CheckoutSdk::CheckoutApi)
      end
    end

    context 'when the domain configuration is missing or contradictory' do
      it 'raises without a subdomain and without the legacy domain opt-out' do
        expect do
          CheckoutSdk.builder
                     .static_keys
                     .with_secret_key(ENV.fetch('CHECKOUT_DEFAULT_SECRET_KEY', nil))
                     .with_environment(CheckoutSdk::Environment.production)
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException,
                           /environment subdomain is required/)
      end

      it 'raises when both the subdomain and the legacy domain are set' do
        expect do
          CheckoutSdk.builder
                     .static_keys
                     .with_secret_key(ENV.fetch('CHECKOUT_DEFAULT_SECRET_KEY', nil))
                     .with_environment(CheckoutSdk::Environment.production)
                     .with_environment_subdomain('12345domain')
                     .with_legacy_domain
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException, /cannot both be set/)
      end

      it 'raises with an invalid subdomain' do
        expect do
          CheckoutSdk.builder
                     .static_keys
                     .with_secret_key(ENV.fetch('CHECKOUT_DEFAULT_SECRET_KEY', nil))
                     .with_environment(CheckoutSdk::Environment.production)
                     .with_environment_subdomain('not a subdomain')
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException,
                           /invalid environment subdomain/)
      end

      it 'raises with a subdomain containing a trailing newline' do
        expect do
          CheckoutSdk.builder
                     .static_keys
                     .with_secret_key(ENV.fetch('CHECKOUT_DEFAULT_SECRET_KEY', nil))
                     .with_environment(CheckoutSdk::Environment.production)
                     .with_environment_subdomain("vkuhvk4v\n")
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException,
                           /invalid environment subdomain/)
      end

      it 'raises with a subdomain containing an embedded newline' do
        expect do
          CheckoutSdk.builder
                     .static_keys
                     .with_secret_key(ENV.fetch('CHECKOUT_DEFAULT_SECRET_KEY', nil))
                     .with_environment(CheckoutSdk::Environment.production)
                     .with_environment_subdomain("evil junk\nvkuhvk4v")
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException,
                           /invalid environment subdomain/)
      end

      it 'does not require a subdomain on the Previous platform' do
        previous_sdk = CheckoutSdk.builder
                                  .previous
                                  .static_keys
                                  .with_secret_key(ENV.fetch('CHECKOUT_PREVIOUS_SECRET_KEY', nil))
                                  .with_environment(CheckoutSdk::Environment.sandbox)
                                  .build
        expect(previous_sdk.class).to eq(CheckoutSdk::Previous::CheckoutApi)
      end
    end

    context 'when building default sdk with incorrect parameters' do
      it 'raises an error when secret key is invalid' do
        expect do
          CheckoutSdk.builder
                     .static_keys
                     .with_secret_key('my wrong key')
                     .with_environment(CheckoutSdk::Environment.production)
                     .with_environment_subdomain('12345domain')
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
                     .with_environment_subdomain('12345domain')
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
                               .with_environment_subdomain('12345domain')
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
                               .with_environment_subdomain('12345domain')
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
                     .with_environment_subdomain('12345domain')
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
                     .with_environment_subdomain('12345domain')
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
                     .with_environment_subdomain('12345domain')
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
                     .with_environment_subdomain('12345domain')
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
                     .with_environment_subdomain('12345domain')
                     .build
        end.to raise_error(CheckoutSdk::CheckoutArgumentException)
      end
    end
  end
end
