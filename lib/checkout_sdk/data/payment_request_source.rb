class CheckoutSdk::PaymentRequestSource
  attr_accessor :type, :token, :billing_address_line1, :billing_address_line2, :billing_city, :billing_state,
                :billing_zip, :billing_country, :phone_country_code, :phone_number, :amount,
                :currency, :payment_type, :reference, :description, :capture, :capture_on, :customer_id,
                :customer_email, :customer_name, :billing_descriptor, :billing_descriptor_name,
                :billing_descriptor_city, :shipping_address_line1, :shipping_address_line2, :shipping_city,
                :shipping_state, :shipping_zip, :shipping_country, :shipping_phone_country_code,
                :shipping_phone_number, :threeds_enabled, :threeds_attempt_n3d, :threeds_eci,
                :threeds_cryptogram, :threeds_xid, :threeds_version, :previous_payment_id, :risk_enabled,
                :success_url, :failure_url, :payment_ip, :recipient_dob, :recipient_account_number,
                :recipient_zip, :recipient_last_name, :processing_mid, :metadata, :cvv, :id, :card_number,
                :card_expiry_month, :card_expiry_year, :card_name, :card_cvv, :card_stored, :customer_id,
                :customer_email, :merchant_initiated

  def data
    { source: source(type),
      amount: amount,
      currency: currency,
      payment_type: payment_type,
      merchant_initiated: merchant_initiated,
      reference: reference,
      description: description,
      capture: capture,
      capture_on: capture_on,
      customer: {
        id: customer_id,
        email: customer_email,
        name: customer_name
      },
      billing_descriptor: {
        name: billing_descriptor_name,
        city: billing_descriptor_city
      },
      shipping: {
        address: {
          address_line1: shipping_address_line1,
          address_line2: shipping_address_line2,
          city: shipping_city,
          state: shipping_state,
          zip: shipping_zip,
          country: shipping_country
        },
        phone: {
          country_code: shipping_phone_country_code,
          number: shipping_phone_number
        }
      },
      "3ds" => {
        enabled: threeds_enabled,
        attempt_n3d: threeds_attempt_n3d,
        eci: threeds_eci,
        cryptogram: threeds_cryptogram,
        xid: threeds_xid,
        version: threeds_version
      },
      previous_payment_id: previous_payment_id,
      risk: {
        enabled: risk_enabled
      },
      success_url: success_url,
      failure_url: failure_url,
      payment_ip: payment_ip,
      recipient: {
        dob: recipient_dob,
        account_number: recipient_account_number,
        zip: recipient_zip,
        last_name: recipient_last_name
      },
      processing: {
        mid: processing_mid
      },
      metadata: metadata
    }
  end

  private

  def source(type)
    case type
    when "id"       then id_type
    when "token"    then token_type
    when "card"     then card_type
    when "customer" then customer_type
    end
  end

  def token_type
    {
      type: type,
      token: token,
      billing_address:  {
        address_line1: billing_address_line1,
        address_line2: billing_address_line2,
        city: billing_city,
        state: billing_state,
        zip: billing_zip,
        country: billing_country
      },
      phone: {
        country_code: phone_country_code,
        number: phone_number
      },
    }
  end

  def card_type
    {
      type: type,
      number: card_number,
      expiry_month: card_expiry_month,
      expiry_year: card_expiry_year,
      name: card_name,
      cvv: card_cvv,
      stored: card_stored,
      billing_address:  {
        address_line1: billing_address_line1,
        address_line2: billing_address_line2,
        city: billing_city,
        state: billing_state,
        zip: billing_zip,
        country: billing_country
      },
      phone: {
        country_code: phone_country_code,
        number: phone_number
      },
    }
  end

  def id_type
    {
      type: type,
      id: id,
      cvv: cvv
    }
  end

  def customer_type
    {
      type: type,
      id: customer_id,
      email: customer_email
    }
  end
end
