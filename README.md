# Checkout.com Ruby SDK
[![build-status](https://github.com/checkout/checkout-sdk-ruby/workflows/build-master/badge.svg)](https://github.com/checkout/checkout-sdk-ruby/actions/workflows/build-master.yml)
![CodeQL](https://github.com/checkout/checkout-sdk-ruby/workflows/CodeQL/badge.svg)

[![build-status](https://github.com/checkout/checkout-sdk-ruby/workflows/build-release/badge.svg)](https://github.com/checkout/checkout-sdk-ruby/actions/workflows/build-release.yml)
[![GitHub release](https://img.shields.io/github/release/checkout/checkout-sdk-ruby.svg)](https://GitHub.com/checkout/checkout-sdk-ruby/releases/)
[![Gem Version](https://badge.fury.io/rb/checkout_sdk.svg)](https://badge.fury.io/rb/checkout_sdk)

[![GitHub license](https://img.shields.io/github/license/checkout/checkout-sdk-ruby.svg)](https://github.com/checkout/checkout-sdk-ruby/blob/master/LICENSE.md)

## Getting started

> **Version 1.0.0 is here!**
> <br/><br/>
> We improved the initialization of SDK making it easier to understand the available options. <br/>
> Now `NAS` accounts are the default instance for the SDK and `ABC` structure was moved to a `previous` prefixes. <br/>

### Gem installer

```sh
gem install checkout_sdk
```

### Bundler

Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that
you need.

```ruby
source 'https://rubygems.org'

gem 'checkout_sdk'
```

### :rocket: Please check in [GitHub releases](https://github.com/checkout/checkout-sdk-ruby/releases) for all the versions available.

### :book: Checkout our official documentation.

* [Official Docs (Default)](https://docs.checkout.com/)
* [Official Docs (Previous)](https://docs.checkout.com/previous)

### :books: Check out our official API documentation guide, where you can also find more usage examples.

* [API Reference (Default)](https://api-reference.checkout.com/)
* [API Reference (Previous)](https://api-reference.checkout.com/previous)

## How to use the SDK

This SDK can be used with two different pair of API keys provided by Checkout. However, using different API keys imply
using specific API features. </br>
Please find in the table below the types of keys that can be used within this SDK.

| Account System | Public Key (example)                    | Secret Key (example)                    |
|----------------|-----------------------------------------|-----------------------------------------|
| Default        | pk_pkhpdtvabcf7hdgpwnbhw7r2uic          | sk_m73dzypy7cf3gf5d2xr4k7sxo4e          |
| Previous       | pk_g650ff27-7c42-4ce1-ae90-5691a188ee7b | sk_gk3517a8-3z01-45fq-b4bd-4282384b0a64 |

Note: sandbox keys have a `sbox_` or `test_` identifier, for Default and Previous accounts respectively.

If you don't have your own API keys, you can sign up for a test
account [here](https://www.checkout.com/get-test-account).

**PLEASE NEVER SHARE OR PUBLISH YOUR CHECKOUT CREDENTIALS.**

### Default

Default keys client instantiation can be done as follows:

```ruby
api = CheckoutSdk.builder
                 .static_keys
                 .with_secret_key('secret_key')
                 .with_public_key('public_key') # optional, only required for operations related with tokens
                 .with_environment(CheckoutSdk::Environment.sandbox)
                 .build
```

### Default OAuth

The SDK supports client credentials OAuth, when initialized as follows:

```ruby
api = CheckoutSdk.builder
                 .oauth
                 .with_authorization_uri('https://access.sandbox.checkout.com/connect/token') # custom authorization URI, optional
                 .with_client_credentials("client_id", "client_secret")
                 .with_scopes([CheckoutSdk::OAuthScopes::VAULT, CheckoutSdk::OAuthScopes::GATEWAY]) # array of scopes
                 .with_environment(CheckoutSdk::Environment.sandbox)
                 .build
```

### Previous

If your pair of keys matches the previous system type, this is how the SDK should be used:

```ruby
api = CheckoutSdk.builder
                 .previous
                 .static_keys
                 .with_secret_key('secret_key')
                 .with_public_key('public_key') # optional, only required for operations related with tokens
                 .with_environment(CheckoutSdk::Environment.sandbox)
                 .build
```

Then just get any client, and start making requests:

```ruby
request = {
  source: {
    type: 'token',
    token: 'tok_4gzeau5o2uqubbk6fufs3m7p54',
  },
  reference: '9bf2e1e9-193a-400a-86d5-debabc495237',
  amount: 10,
  currency: 'GBP',
}
payment_response = api.payments.request_payment(request)
```

## Logging

The SDK supports custom Log provider, you need to provide your log configuration via SDK initialization by default uses `Logger` from Ruby.

```ruby
api = CheckoutSdk.builder
                 .static_keys
                 .with_secret_key('secret_key')
                 .with_public_key('public_key') # optional, only required for operations related with tokens
                 .with_environment(CheckoutSdk::Environment.sandbox)
                 .with_logger(logger) # your own custom configuration
                 .build
```

## Exception handling

All the API responses that do not fall in the 2** status codes will cause a `CheckoutSdk::CheckoutApiException`. The
exception
encapsulates the `http_metadata` and a map of `error_details`, if available.

## Custom Http Client

Ruby SDK supports your own configuration for `http client` using `Faraday::Connection` object, you can pass
through the
SDK instantiation as follows:

```ruby
http_client = Faraday.new do |conn|
  conn.options.timeout = 10
  conn.proxy "http://localhost:8080"
end

api = CheckoutSdk.builder
                 .static_keys
                 .with_secret_key('secret_key')
                 .with_public_key('public_key') # optional, only required for operations related with tokens
                 .with_environment(CheckoutSdk::Environment.sandbox)
                 .with_http_client(http_client)
                 .build
```

You don't need to specify the URL for Faraday constructor the SDK grabs the belong URI from `CheckoutSdk::Environment`
however if you want to
use specific URI's without a proxy you can create the `Environment` object as follows.

```ruby
environment = CheckoutSdk::Environment.new('https://the.base.uri/', # the uri for all CKO operations
                                           'https://the.oauth.uri/connect/token', # the uri used for OAUTH authorization, only required for OAuth operations
                                           'https://the.files.uri/', # the uri used for Files operations, only required for Accounts module
                                           'https://the.transfers.uri/', # the uri used for Transfer operations, only required for Transfers module
                                           'https://the.balances.uri/', # the uri used for Balances operations, only required for Balances module
                                           false)
```

If you want to provide your own `http client` and wants to use the `upload_file` functionality from `Disputes` or `Accounts` modules, you
also need to specify the custom `http client` for `multipart requests`:

```ruby
http_client = Faraday.new do |conn|
  conn.options.timeout = 10
  conn.proxy "http://localhost:8080"
  conn.response :raise_error
end

multipart_client = Faraday.new do |f|
  f.request :multipart
end

api = CheckoutSdk.builder
                 .static_keys
                 .with_secret_key('secret_key')
                 .with_public_key('public_key') # optional, only required for operations related with tokens
                 .with_environment(CheckoutSdk::Environment.sandbox)
                 .with_http_client(http_client)
                 .with_multipart_http_client(multipart_client)
                 .build
```

If you want to use your own `http_client` and wants to use `Reports` module, the `get_report_file` function follows a redirect URL from Checkout, 
Ruby SDK uses `faraday-follow-redirects` which is an [open source](https://github.com/tisba/faraday-follow-redirects) solution that came after Faraday 2.0 deprecation, 
you must add it otherwise Ruby SDK will not be able to download the contents file, or provide your custom redirect adapter.

```ruby
http_client = Faraday.new do |f|
  f.response :follow_redirects
  f.response :raise_error
end

api = CheckoutSdk.builder
                 .static_keys
                 .with_secret_key('secret_key')
                 .with_public_key('public_key') # optional, only required for operations related with tokens
                 .with_environment(CheckoutSdk::Environment.sandbox)
                 .with_http_client(http_client)
                 .build
```

## Building from source

Once you check out the code from GitHub, the project can be built using gem:

```sh
gem build checkout_sdk.gemspec
```

The execution of integration tests require the following environment variables set in your system:

* For default account systems (NAS): `CHECKOUT_DEFAULT_PUBLIC_KEY` & `CHECKOUT_DEFAULT_SECRET_KEY`
* For default account systems (OAuth): `CHECKOUT_DEFAULT_OAUTH_CLIENT_ID` & `CHECKOUT_DEFAULT_OAUTH_CLIENT_SECRET`
* For Previous account systems (ABC): `CHECKOUT_PREVIOUS_PUBLIC_KEY` & `CHECKOUT_PREVIOUS_SECRET_KEY`

## Code of Conduct

Please refer to [Code of Conduct](CODE_OF_CONDUCT.md)

## Licensing

[MIT](LICENSE.md)
