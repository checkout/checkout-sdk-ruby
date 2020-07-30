[![GitHub license](https://img.shields.io/github/license/checkout/checkout-sdk-ruby.svg)](https://github.com/checkout/checkout-sdk-ruby/blob/master/LICENSE) [![GitHub release](https://img.shields.io/github/release/checkout/checkout-sdk-ruby.svg)](https://GitHub.com/checkout/checkout-sdk-ruby/releases/)

<p align="center"><img src="https://i.ibb.co/5Mx7ZsS/Screenshot-2020-07-30-at-17-20-31.png" width="20%"></p>

# Checkout.com Ruby SDK

# :rocket: Install

Add this line to your application's Gemfile:

```ruby
gem 'checkout_sdk'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install checkout_sdk
```

# :wrench: Configure

API keys must be configured in the gem setup. You can do this anywhere in your application before you make API calls using the gem.

```ruby
CheckoutSdk.configure do |config|
  config.secret_key = ENV['SECRET_KEY']
  config.public_key = ENV['PUBLIC_KEY']
  config.base_url   = ENV['BASE_URL']
end
```

# :book: Documentation

You can see the [SDK documentation here](https://checkout.github.io/checkout-sdk-ruby/getting_started/).

# :dash: Quickstart

#### Source Type: `token`
A card token can be obtained using one of Checkout.com's JavaScript frontend solutions such as [Frames](https://docs.checkout.com/docs/frames "Frames") or any of the [mobile SDKs](https://docs.checkout.com/docs/sdks#section-mobile-sdk-libraries "Mobile SDKs")

```ruby
payment_request_source = CheckoutSdk::PaymentRequestSource.new
payment_request_source.type = "token"
payment_request_source.token = "tok_..."
payment_request_source.amount = 2022
payment_request_source.currency = "GBP"

api_resource = CheckoutSdk::ApiResource.new

# Send API call
response = api_resource.request_payment(payment_request_source)

# response parsing
response.data           # => {...}
response.body           # => "..."
response.headers        # => {...}
response.remote_ip      # => "..."
response.status         # => 200
response.remote_ip      # => "..."
response.local_port     # => 51601
response.local_address  # => "..."
```

#### Source Type: `id`

```ruby
payment_request_source = CheckoutSdk::PaymentRequestSource.new
payment_request_source.type = "id"
payment_request_source.token = "src_..."
payment_request_source.amount = 2022
payment_request_source.currency = "GBP"

api_resource = CheckoutSdk::ApiResource.new

# Send API call
response = api_resource.request_payment(payment_request_source)

# response parsing
response.data           # => {...}
response.body           # => "..."
response.headers        # => {...}
response.remote_ip      # => "..."
response.status         # => 200
response.remote_ip      # => "..."
response.local_port     # => 51601
response.local_address  # => "..."
```


#### Source Type: `card`
[Fully PCI Compliant](https://docs.checkout.com/docs/pci-compliance) merchants only
```ruby
payment_request_source = CheckoutSdk::PaymentRequestSource.new
payment_request_source.type = "card"
payment_request_source.card_number = "4242424242424242"
payment_request_source.card_expiry_month = 6
payment_request_source.card_expiry_year = 2025
payment_request_source.card_name = "Bruce Wayne"
payment_request_source.card_cvv = "100"
payment_request_source.amount = 2022
payment_request_source.currency = "GBP"

api_resource = CheckoutSdk::ApiResource.new

# Send API call
response = api_resource.request_payment(payment_request_source)

# response parsing
response.data           # => {...}
response.body           # => "..."
response.headers        # => {...}
response.remote_ip      # => "..."
response.status         # => 200
response.remote_ip      # => "..."
response.local_port     # => 51601
response.local_address  # => "..."
```

# :warning: Boolean/falsy values

"nil" or empty strings will be stripped from API calls

```ruby
# ignored
payment_request_source.capture = nil
payment_request_source.capture = ""
```

but "false" or 0 are retained and sent in the request

```ruby
# sent
payment_request_source.capture = false
payment_request_source.capture = 0
```
See [api_resource_spec](https://github.com/checkout/checkout-sdk-ruby/blob/master/spec/checkout_sdk/api_resource_spec.rb#L10-L24) for details.

# :rotating_light: Tests

```bash
$ rspec
```
