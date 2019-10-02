class CheckoutSdk::RefundPayment
  attr_accessor :id, :amount, :reference, :metadata

  def data
    {
      amount: amount,
      reference: reference,
      metadata: metadata
    }
  end
end
