RSpec.describe CheckoutSdk::Previous::Sources do

  context '.create_sepa_source', skip: 'responding 502 in sandbox' do
    context 'when creating a SEPA source with valid parameters' do
      it 'creates SEPA source correctly' do
        source_data = CheckoutSdk::Previous::Sources::SourceData.new
        source_data.first_name = Helpers::DataFactory::NAME
        source_data.last_name = Helpers::DataFactory::LAST_NAME
        source_data.account_iban = 'DE68100100101234567895'
        source_data.bic = 'PBNKDEFFXXX'
        source_data.billing_descriptor = '.RUBY SDK test'
        source_data.mandate_type = CheckoutSdk::Previous::Sources::MandateType::SINGLE

        request = CheckoutSdk::Previous::Sources::SepaSourceRequest.new
        request.reference = 'Ruby SDK test'
        request.phone = phone
        request.billing_address = address
        request.source_data = source_data

        response = previous_sdk.sources.create_sepa_source request

        assert_response response, %w[type
                                     customer.id
                                     id
                                     customer.id
                                     response_code
                                     response_data.mandate_reference
                                     _links.sepa:mandate-get
                                     _links.sepa:mandate-cancel]
      end
    end
  end
end
