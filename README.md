# CheckoutSdk

You are reading documentation for version: 0.1.1

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
p = CheckoutSdk::PaymentRequestSource.new
p.type = "card"
p.card_number = "4242424242424242"
p.card_expiry_month = 6
p.card_expiry_year = 2025
p.card_name = "Bruce Wayne"
p.card_cvv = "100"
p.amount = 2022
p.currency = "GBP"
p.capture = true
p.threeds_enabled = false
p.threeds_attempt_n3d = false
p.recipient_dob = "1992-04-06"
p.recipient_account_number = "1234567890"
p.recipient_zip = "12345"
p.recipient_last_name = "Elmo"
p.risk_enabled = true
p.billing_descriptor_name = "Nancy"
p.billing_descriptor_city = "Berlin"
p.processing_mid = "CheckoutSdk"

r = CheckoutSdk::ApiResource.new
r.request_payments(p)
```

## Tests

    $ rspec
