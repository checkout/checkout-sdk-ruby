---
id: tokens
title: Tokens
---

export const Highlight = ({children, color}) => (
<span
style={{
      color: color,
      padding: '0.2rem',
    }}>
{children}
</span>
);

You can find a list of request body parameters and possible outcomes [here](https://api-reference.checkout.com/#tag/Tokens).

## Request a token for <Highlight color="#25c2a0">Apple Pay</Highlight>

```ruby
header_data = { "ephemeralPublicKey" => "XXX",
                "publicKeyHash" => "XXX",
                "transactionId" => "XXX" }

token_request_source = CheckoutSdk::RequestToken.new
token_request_source.type = "applepay"
token_request_source.token_data_version = "EC_v1"
token_request_source.token_data_data = "XXX"
token_request_source.token_data_signature = "XXX"
token_request_source.token_data_header = header_data

# Send API call
response = api_resource.request_token(token_request_source)

# response parsing
puts(response.data) # => {...}
puts(response.body) # => "..."
```

## Request a token for <Highlight color="#25c2a0">Google Pay</Highlight>

const token = await cko.tokens.request({
    // type:"googlepay" is inferred
    token_data: {
        protocolVersion: 'EC_v1',
        signature: 'XXX',
        signedMessage: 'XXX'
    }
});

```ruby
token_request_source = CheckoutSdk::RequestToken.new
token_request_source.type = "googlepay"
token_request_source.token_data_protocolVersion = "ECv1"
token_request_source.token_data_signature = "XXX"
token_request_source.token_data_signedMessage = "XXX"

# Send API call
response = api_resource.request_token(token_request_source)

# response parsing
puts(response.data) # => {...}
puts(response.body) # => "..."
```

## Request a token for <Highlight color="#25c2a0">raw card details</Highlight>

:::warning

If you do not have SAQ-D level PCI Compliance, this interaction can only be done in the Sandbox environment. This is in case you want to unit test your code and need a token to make a payment. In the Production environment, you need to use an integrated solution such as **[Frames](https://docs.checkout.com/quickstart/integrate/frames)** to generate the token for you.

:::

```ruby
token_request_source = CheckoutSdk::RequestToken.new
token_request_source.type = "card"
token_request_source.card_number = "4242424242424242"
token_request_source.card_expiry_month = 6
token_request_source.card_expiry_year = 28
token_request_source.card_cvv = "100"

# Send API call
response = api_resource.request_token(token_request_source)

# response parsing
puts(response.data) # => {...}
puts(response.body) # => "..."
```
