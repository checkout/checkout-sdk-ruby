class Checkout::PaymentSource
  attr_accessor :type, :reference, :billing_address_line1, :billing_address_line2,
                :billing_city, :billing_state, :billing_zip, :billing_country,
                :source_phone_country_code, :source_phone_number, :customer_id,
                :customer_email, :customer_name, :source_data_first_name,
                :source_data_last_name, :source_data_account_iban, :source_data_bic,
                :source_data_billing_descriptor, :source_data_mandate_type

  def data
    {
      type: type,
      reference: reference,
      billing_address:  {
        address_line1: billing_address_line1,
        address_line2: billing_address_line2,
        city: billing_city,
        state: billing_state,
        zip: billing_zip,
        country: billing_country
      },
      phone: {
        country_code: source_phone_country_code,
        number: source_phone_number
      },
      customer: {
        id: customer_id,
        email: customer_email,
        name: customer_name
      },
      source_data: {
        first_name: source_data_first_name,
        last_name: source_data_last_name,
        account_iban: source_data_account_iban,
        bic: source_data_bic,
        billing_descriptor: source_data_billing_descriptor,
        mandate_type: source_data_mandate_type
      }
    }
  end
end
