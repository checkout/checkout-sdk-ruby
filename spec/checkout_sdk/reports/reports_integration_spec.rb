RSpec.describe CheckoutSdk::Reports do

  before(:all) do
    @query = CheckoutSdk::Reports::ReportsQuery.new
    @query.created_after = DateTime.now.prev_day 7
    @query.created_before = DateTime.now
  end

  describe '.get_all_reports' do
    context 'when querying with valid filters' do
      it 'returns valid reports' do
        response = default_sdk.reports.get_all_reports @query

        assert_response response,
                        %w[metadata
                           count
                           limit
                           data
                           _links]

        response.data&.each do |report|
          assert_response report,
                          %w[id
                             created_on
                             type
                             description
                             account
                             from
                             to]
        end
      end
    end
  end

  describe '.get_report_details' do
    context 'when fetching valid report' do
      subject(:report) {
        response = default_sdk.reports.get_all_reports @query
        assert_response response, %w[data]
        response.data[0]
      }
      it 'returns report details' do
        details = default_sdk.reports.get_report_details report.id

        assert_response details,
                        %w[id
                           created_on
                           type
                           description
                           account
                           from
                           to]

        expect(details.id).to eq report.id
        expect(details.created_on).to eq report.created_on
        expect(details.type).to eq report.type
        expect(details.description).to eq report.description
        expect(details.account).to eq report.account
        expect(details.from).to eq report.from
        expect(details.to).to eq report.to
      end
    end
  end
end
