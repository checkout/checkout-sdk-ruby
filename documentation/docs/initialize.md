---
id: initialize
title: Initialize
---

## Configuration

API keys must be configured in the gem setup. You can do this anywhere in your application before you make API calls using the gem.

```ruby
CheckoutSdk.configure do |config|
  config.secret_key = "your secret key"
  config.public_key = "your public key"
  config.base_url   = "https://api.sandbox.checkout.com" #for sandbox
end

api_resource = CheckoutSdk::ApiResource.new
```

