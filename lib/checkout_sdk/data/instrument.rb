# Payment Method aka "instrument"
CheckoutSdk::Instrument = Struct.new(:token, :customer, :verify, :currency, keyword_init: true) do
  # @return [Hash<Symbol>]
  def data
    if verify
      {
        source: {
          type: 'token',
          token: token
        },
        amount: 0, # We are adding 0 amount to verify if the payment method can be charged
        currency: currency || 'USD',
        customer: customer
      }
    else
      {
        type: 'token',
        token: token,
        customer: customer
      }
    end
  end
end
