RSpec.describe CheckoutSdk::StandaloneAccountUpdater do
  skip 'Requires sandbox OAuth credentials with the `vault:real-time-account-updater` scope' do
    let(:client) { oauth_sdk.standalone_account_updater }

    describe '#update_card' do
      it 'updates a card via account-updater/cards' do
        request = CheckoutSdk::StandaloneAccountUpdater::AccountUpdaterRequest.new
        request.source_options = CheckoutSdk::StandaloneAccountUpdater::AccountUpdaterSourceOptions.new
        request.source_options.card = CheckoutSdk::StandaloneAccountUpdater::AccountUpdaterCard.new
        request.source_options.card.number = Helpers::DataFactory::CARD_NUMBER
        request.source_options.card.expiry_month = Helpers::DataFactory::EXPIRY_MONTH
        request.source_options.card.expiry_year = Helpers::DataFactory::EXPIRY_YEAR

        response = client.update_card(request)
        expect(response).not_to be_nil
      end
    end
  end
end
