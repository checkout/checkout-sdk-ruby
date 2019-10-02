class Checkout::RequestToken
  attr_accessor :type, :token_data_version, :token_data_data, :token_data_signature,
                :token_data_header, :token_data_signature, :token_data_protocolVersion,
                :token_data_signedMessage, :card_number, :card_expiry_month, :card_expiry_year,
                :card_name, :card_cvv, :billing_address_line1, :billing_address_line2, :billing_city,
                :billing_state, :billing_zip, :billing_country, :phone_country_code, :phone_number

  def data
    if type == "card"
      card_type
    else
      {
        type: type,
        token_data: token_data(type)
      }
    end
  end

  private

  def token_data(type)
    case type
    when "applepay"  then applepay_type
    when "googlepay" then googlepay_type
    end
  end

  def applepay_type
    {
      version: token_data_version,
      data: token_data_data,
      signature: token_data_signature,
      header: token_data_header
    }
  end

  def googlepay_type
    {
      signature: token_data_signature,
      protocolVersion: token_data_protocolVersion,
      signedMessage: token_data_signedMessage
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
      }
    }
  end
end
