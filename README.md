# Checkout

You are reading documentation for version: 0.1.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'checkout'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install checkout

## Configuration

API keys must be configured in the gem setup. You can do this anywhere in your application before you make API calls using the gem.

```ruby
Checkout.configure do |config|
  config.secret_key = ENV['SECRET_KEY']
  config.public_key = ENV['PUBLIC_KEY']
  config.base_url   = ENV['BASE_URL']
end
```

## Usage

```ruby
p = Checkout::PaymentRequestSource.new
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

r = Checkout::ApiResource.new
r.request_payments(p)
```
