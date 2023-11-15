class CheckoutSdk::Configuration
  attr_accessor :secret_key, :public_key, :base_url, :persistent

  def initialize(secret_key: nil, public_key: nil, base_url: nil)
    @secret_key = secret_key
    @public_key = public_key
    @base_url = base_url
    @persistent = true
  end
end
