# CheckoutSdk

You are reading documentation for version: 0.1.4

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'checkout_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install checkout_sdk

## Configuration

API keys must be configured in the gem setup. You can do this anywhere in your application before you make API calls using the gem.

```ruby
CheckoutSdk.configure do |config|
  config.secret_key = ENV['SECRET_KEY']
  config.public_key = ENV['PUBLIC_KEY']
  config.base_url   = ENV['BASE_URL']
end
```

## Usage

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
payment_request_source.capture = true
payment_request_source.threeds_enabled = false
payment_request_source.threeds_attempt_n3d = false
payment_request_source.recipient_dob = "1992-04-06"
payment_request_source.recipient_account_number = "1234567890"
payment_request_source.recipient_zip = "12345"
payment_request_source.recipient_last_name = "Elmo"
payment_request_source.risk_enabled = true
payment_request_source.billing_descriptor_name = "Nancy"
payment_request_source.billing_descriptor_city = "Berlin"
payment_request_source.processing_mid = "CheckoutSdk"


api_resource = CheckoutSdk::ApiResource.new

# Send API call
response = api_resource.request_payments(payment_request_source)

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

## Tests

    $ rspec
