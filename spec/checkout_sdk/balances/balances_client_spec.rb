RSpec.describe CheckoutSdk::Balances do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Balances::BalancesClient.new(api_client_mock, configuration_mock) }

  let(:entity_id) { 'ent_w4jelhppmfiufdnatam37wrfc4' }
  let(:currency_account_id) { 'ca_g5y7d6jo4e2urgforcbf2ey5jm' }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('oauth')
  end

  describe '#retrieve_entity_balances' do
    it 'GETs balances/{entity_id} with the query' do
      query = CheckoutSdk::Balances::BalancesQuery.new
      expect(api_client_mock).to receive(:invoke_get)
        .with('balances/ent_w4jelhppmfiufdnatam37wrfc4', 'oauth', query)
        .and_return('response')
      expect(client.retrieve_entity_balances(entity_id, query)).to eq('response')
    end
  end

  describe '#retrieve_top_up_instructions' do
    it 'GETs the exact top-up instructions path' do
      expect(api_client_mock).to receive(:invoke_get)
        .with(
          'entities/ent_w4jelhppmfiufdnatam37wrfc4/currency-accounts/' \
          'ca_g5y7d6jo4e2urgforcbf2ey5jm/top-up-instructions',
          'oauth'
        )
        .and_return('response')
      expect(client.retrieve_top_up_instructions(entity_id, currency_account_id)).to eq('response')
    end

    it 'passes no query parameters' do
      # The endpoint declares none; invoke_get must be called with exactly two arguments.
      expect(api_client_mock).to receive(:invoke_get) do |*args|
        expect(args.length).to eq(2)
        'response'
      end
      client.retrieve_top_up_instructions(entity_id, currency_account_id)
    end

    # Both values are interpolated straight into the path, so a blank one would build a malformed
    # URL. The guard must reject it before any request is made.
    [
      ['nil entity_id', nil, 'ca_g5y7d6jo4e2urgforcbf2ey5jm', 'entity_id cannot be blank'],
      ['empty entity_id', '', 'ca_g5y7d6jo4e2urgforcbf2ey5jm', 'entity_id cannot be blank'],
      ['blank entity_id', '   ', 'ca_g5y7d6jo4e2urgforcbf2ey5jm', 'entity_id cannot be blank'],
      ['nil currency_account_id', 'ent_w4jelhppmfiufdnatam37wrfc4', nil,
       'currency_account_id cannot be blank'],
      ['empty currency_account_id', 'ent_w4jelhppmfiufdnatam37wrfc4', '',
       'currency_account_id cannot be blank'],
      ['blank currency_account_id', 'ent_w4jelhppmfiufdnatam37wrfc4', '   ',
       'currency_account_id cannot be blank']
    ].each do |label, given_entity_id, given_currency_account_id, message|
      it "rejects #{label} without calling the API" do
        expect(api_client_mock).not_to receive(:invoke_get)
        expect { client.retrieve_top_up_instructions(given_entity_id, given_currency_account_id) }
          .to raise_error(CheckoutSdk::CheckoutArgumentException, message)
      end
    end
  end

  describe 'BalancesQuery serialization' do
    # The swagger declares these two parameters in camelCase. Ruby emits instance-variable names
    # verbatim unless JsonSerializer::KEYS_TRANSFORMATIONS maps them, so these pin the wire
    # names: without the mapping the API silently ignores both parameters and returns no
    # currency_account_id, with no error.
    it 'maps with_currency_account_id and balances_at to camelCase' do
      query = CheckoutSdk::Balances::BalancesQuery.new
      query.query = 'currency:GBP'
      query.with_currency_account_id = true
      query.balances_at = '2026-05-06T13:59:59Z'

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(query)

      expect(hash['withCurrencyAccountId']).to be true
      expect(hash['balancesAt']).to eq('2026-05-06T13:59:59Z')
      expect(hash['query']).to eq('currency:GBP')
      expect(hash).not_to have_key('with_currency_account_id')
      expect(hash).not_to have_key('balances_at')
    end

    it 'agrees with BalancesQuery#to_h' do
      query = CheckoutSdk::Balances::BalancesQuery.new
      query.with_currency_account_id = true

      serialized = CheckoutSdk::JsonSerializer.to_custom_hash(query)

      # to_h is a convenience that must not drift from what the serializer produces.
      expect(query.to_h.transform_keys(&:to_s)).to eq(serialized)
    end
  end
end
