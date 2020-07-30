---
id: sources
title: Sources
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

You can find a list of request body parameters and possible outcomes [here](https://api-reference.checkout.com/#tag/Sources).

## Add a <Highlight color="#25c2a0">SEPA source</Highlight>

:::note

SEPA is not enabled by default, so please let your account manager know if you want to use it.

:::

```ruby
payment_source = CheckoutSdk::PaymentSource.new
payment_source.type = "sepa"
payment_source.reference = "X-080957-N34"

payment_source.customer_id = "cus_y3oqhf46pyzuxjbcn2giaqnb44"
payment_source.customer_email = "jokershere@gmail.com"
payment_source.customer_name = "Jack Napier"

payment_source.billing_address_line1 = "Checkout.com"
payment_source.billing_address_line2 = "Shepherdess Walk"
payment_source.billing_city = "London"
payment_source.billing_state = "London"
payment_source.billing_zip = "N1 7LH"
payment_source.billing_country = "GB"

payment_source.phone_country_code = "+1"
payment_source.phone_number = "415 555 2671"

payment_source.source_data_first_name = "Marcus"
payment_source.source_data_last_name = "Barrilius Maximus"
payment_source.source_data_account_iban = "DE25100100101234567893"
payment_source.source_data_bic = "PBNKDEFFXXX"
payment_source.source_data_billing_descriptor = "Ruby SDK test"
payment_source.source_data_mandate_type = "single"

response = api_resource.add_payment_source(payment_source)
```
