---
id: environment
title: Environment
---

The SDK will target an environment based on the **base_url** value you provide when you initialize it:

**Sandbox**: https://api.sandbox.checkout.com

**Live**: https://api.checkout.com

:::caution

Public and secret key pairs will only work for their relevant environment. Sandbox keys begin with "pk&#95;test&#95;" or "sk&#95;test&#95;". You will receive separate Live keys for use in your production environment when going live with Checkout.com.

:::

## Testing

If you are testing in the Sandbox environment, Checkout.com provides a list of [test card details](https://docs.checkout.com/testing/test-card-numbers). You can also simulate a lot of edge cases like Declines, by using [special transaction values](https://docs.checkout.com/testing/response-code-testing).

:::note

You can also test 3D Secure with the test cards provided. If you want to test 3DS 2 flows, use the cards mentioned [here](https://docs.checkout.com/testing/3d-secure-testing).

:::
