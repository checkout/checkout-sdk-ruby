class CheckoutSdk::VoidPayment
  attr_accessor :id, :reference, :metadata

  def data
    {
      reference: reference,
      metadata: metadata
    }
  end
end
