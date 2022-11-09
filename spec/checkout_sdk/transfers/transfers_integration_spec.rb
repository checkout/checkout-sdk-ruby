RSpec.describe CheckoutSdk::Transfers do

  describe '.initiate_transfer_of_funds' do
    context 'when requesting transfer of funds' do
      it 'should initiates transfer of funds' do
        request = create_transfer
        response = oauth_sdk.transfers.initiate_transfer_of_funds(request)
        expect(response).not_to be_nil
        expect(response.status).to eq('pending')
      end

      it 'should fail when requesting idempotent transfer' do
        request = create_transfer
        response = oauth_sdk.transfers.initiate_transfer_of_funds(request)
        expect(response).not_to be_nil
        expect(response.status).to eq('pending')

        idempotency_key = '795900f2-aadd-476c-9093-df65c99bf37a'
        expect { oauth_sdk.transfers.initiate_transfer_of_funds(request, idempotency_key) }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.http_metadata.status_code).to eq 409 }
      end
    end
  end

  describe '.retrieve_transfer' do
    context 'when fetching a transfer of funds' do
      it 'should successfully retrieve transfer information' do
        request = create_transfer
        create_response = oauth_sdk.transfers.initiate_transfer_of_funds(request)

        retrieve_response = oauth_sdk.transfers.retrieve_transfer(create_response.id)
        expect(retrieve_response).not_to be_nil
        assert_response retrieve_response, %w[id
                                              requested_on
                                              status
                                              transfer_type
                                              destination
                                              source]
      end
    end
  end
end

def create_transfer
  transfer_source = CheckoutSdk::Transfers::TransferSource.new
  transfer_source.id = 'ent_kidtcgc3ge5unf4a5i6enhnr5m'
  transfer_source.amount = 100
  transfer_destination = CheckoutSdk::Transfers::TransferDestination.new
  transfer_destination.id = 'ent_w4jelhppmfiufdnatam37wrfc4'
  create_transfer = CheckoutSdk::Transfers::CreateTransfer.new
  create_transfer.transfer_type = CheckoutSdk::Transfers::TransferType::COMMISSION
  create_transfer.source = transfer_source
  create_transfer.destination = transfer_destination
  create_transfer
end
