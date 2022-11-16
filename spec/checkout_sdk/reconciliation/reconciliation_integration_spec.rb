RSpec.describe CheckoutSdk::Previous::Reconciliation do

  before(:all) do
    skip 'Only available in production'
    @api = build_prod_api
    @filter = build_query_filter
  end

  describe '.query_payments_report' do
    context 'when querying payments report' do
      it 'should retrieve payments report' do

        request = CheckoutSdk::Previous::Reconciliation::ReconciliationQueryPaymentsFilter.new
        request.from = @filter.from
        request.to = @filter.to

        response = @api.reconciliation.query_payments_report request

        expect(response).not_to be_nil
        expect(response.metadata.status_code).to eq 200
      end
    end
  end

  describe '.single_payment_report' do
    context 'when requesting single payments report' do
      it 'should raise (404 - not_found)' do
        expect { @api.reconciliation.single_payment_report 'payment_id' }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.http_metadata.status_code).to eq 404 }
      end
    end
  end

  describe '.query_statements_report' do
    context 'when querying statements report' do
      it 'should retrieve statements report' do

        response = @api.reconciliation.query_statements_report @filter
        expect(response).not_to be_nil
        response.data&.each do |statement|
          assert_response statement, %w[id
                                        period_start
                                        period_end
                                        date
                                        payouts]
        end
      end
    end
  end

  describe '.retrieve_csv_payment_report' do
    context 'when requesting csv payments report' do
      it 'should retrieve csv payments report' do

        response = @api.reconciliation.retrieve_csv_payment_report @filter
        expect(response).not_to be_nil
        expect(response.contents).not_to be_nil
      end
    end
  end

  describe '.retrieve_csv_single_statement_report' do
    context 'when requesting csv single statement report' do
      it 'should retrieve csv single statement report' do

        response = @api.reconciliation.retrieve_csv_single_statement_report 'statement_id'
        expect(response).not_to be_nil
        expect(response.contents).not_to be_nil
      end
    end
  end

  describe '.retrieve_csv_statements_report' do
    context 'when requesting csv statement report' do
      it 'should retrieve csv statement report' do

        response = @api.reconciliation.retrieve_csv_statements_report @filter
        expect(response).not_to be_nil
        expect(response.contents).not_to be_nil
      end
    end
  end

end

# @return [CheckoutSdk::Previous::CheckoutApi]
def build_prod_api
  CheckoutSdk.builder
             .previous
             .static_keys
             .with_secret_key(ENV.fetch('CHECKOUT_PREVIOUS_SECRET_KEY_PROD', nil))
             .with_environment(CheckoutSdk::Environment.production)
             .build
end

# @return [CheckoutSdk::Common::DateRangeQueryFilter]
def build_query_filter
  filter = CheckoutSdk::Common::DateRangeQueryFilter.new
  filter.from = DateTime.now - 15
  filter.to = DateTime.now
  filter
end
