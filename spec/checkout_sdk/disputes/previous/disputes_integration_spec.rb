RSpec.describe CheckoutSdk::Disputes do
  include Previous::PaymentsHelper

  describe 'Previous' do
    describe '.query' do
      context 'when querying with valid DateTime filters' do
        it 'returns valid disputes' do
          query = CheckoutSdk::Disputes::DisputesQueryFilter.new
          query.limit = 100
          query.from = DateTime.now.prev_year(1)
          query.to = DateTime.now

          response = previous_sdk.disputes.query(query)

          expect(response).not_to be nil
          expect(response.total_count).to be > 0
          expect(response.from).not_to be nil
          expect(response.to).not_to be nil
        end
      end

      context 'when querying with valid Time filters' do
        it 'returns valid disputes' do
          query = CheckoutSdk::Disputes::DisputesQueryFilter.new
          query.limit = 100
          query.from = Time.parse(DateTime.now.prev_year(1).to_s).iso8601
          query.to = Time.now.iso8601

          response = previous_sdk.disputes.query(query)

          expect(response).not_to be nil
          expect(response.total_count).to be > 0
          expect(response.from).not_to be nil
          expect(response.to).not_to be nil
        end
      end

      context 'when querying with valid filters but no matches found' do
        it 'returns null data' do
          query = CheckoutSdk::Disputes::DisputesQueryFilter.new
          query.limit = 100
          query.from = DateTime.now
          query.to = DateTime.now

          response = previous_sdk.disputes.query(query)

          expect(response).not_to be nil
          expect(response.total_count).to eq(0)
        end
      end

      context 'when querying with invalid filters' do
        it 'raises an error' do
          query = CheckoutSdk::Disputes::DisputesQueryFilter.new
          query.limit = 300

          expect { previous_sdk.disputes.query(query) }.to raise_error(CheckoutSdk::CheckoutApiException)
        end
      end
    end

    describe '.get_dispute_details' do
      context 'when fetching a valid dispute' do
        subject(:dispute) { get_disputes_previous(from: DateTime.now.prev_year(1), to: DateTime.now).data.first }
        it 'returns dispute details' do
          response = previous_sdk.disputes.get_dispute_details(dispute.id)

          expect(response).not_to be nil
          expect(response.id).to eq dispute.id
          expect(response.entity_id).to eq dispute.entity_id
          expect(response.category).to eq dispute.category
          expect(response.amount).to eq dispute.amount
          expect(response.currency).to eq dispute.currency
          expect(response.status).to eq dispute.status
        end
      end

      context 'when fetching with invalid dispute ID' do
        it 'raises an error' do
          expect { previous_sdk.disputes.get_dispute_details("not_found") }.to raise_error(CheckoutSdk::CheckoutApiException)
        end
      end
    end

    skip 'full disputes flow' do

      before(:context) do
        payment_response = make_card_payment(amount: 1040, capture: true)

        proc = -> { get_disputes_previous(payment_id: payment_response.id) }
        predicate = ->(response) { there_are_disputes response }

        disputes = retriable(proc, predicate)

        @dispute = disputes.data.first
        @file_id = upload_file_previous.id
      end

      describe '.put_evidence' do
        context "when updating valid dispute evidence" do
          it 'should update successfully' do
            request = CheckoutSdk::Disputes::DisputeEvidenceRequest.new
            request.proof_of_delivery_or_service_file = @file_id
            request.proof_of_delivery_or_service_text = 'proof of delivery or service text'
            request.invoice_or_receipt_file = @file_id
            request.invoice_or_receipt_text = 'proof of receipt text'
            request.invoice_showing_distinct_transactions_file = @file_id
            request.invoice_showing_distinct_transactions_text = 'invoice showing distinct transactions text'
            request.customer_communication_file = @file_id
            request.customer_communication_text = 'customer communication text'
            request.refund_or_cancellation_policy_file = @file_id
            request.refund_or_cancellation_policy_text = 'refund or cancellation policy text'
            request.recurring_transaction_agreement_file = @file_id
            request.recurring_transaction_agreement_text = 'recurring transaction agreement text'
            request.additional_evidence_file = @file_id
            request.additional_evidence_text = 'additional evidence text'
            request.proof_of_delivery_or_service_date_file = @file_id
            request.proof_of_delivery_or_service_date_text = 'proof of delivery or service date text'

            response = previous_sdk.disputes.put_evidence(@dispute.id, request)

            # TODO validate 204 status
          end

          it 'should have new values for updated fields' do
            response = previous_sdk.disputes.get_evidence(@dispute.id)

            expect(response).not_to be nil
            expect(response.proof_of_delivery_or_service_file).to eq @file_id
            expect(response.proof_of_delivery_or_service_text).to eq 'proof of delivery or service text'
            expect(response.invoice_or_receipt_file).to eq @file_id
            expect(response.invoice_or_receipt_text).to eq 'proof of receipt text'
            expect(response.invoice_showing_distinct_transactions_file).to eq @file_id
            expect(response.invoice_showing_distinct_transactions_text).to eq 'invoice showing distinct transactions text'
            expect(response.customer_communication_file).to eq @file_id
            expect(response.customer_communication_text).to eq 'customer communication text'
            expect(response.refund_or_cancellation_policy_file).to eq @file_id
            expect(response.refund_or_cancellation_policy_text).to eq 'refund or cancellation policy text'
            expect(response.recurring_transaction_agreement_file).to eq @file_id
            expect(response.recurring_transaction_agreement_text).to eq 'recurring transaction agreement text'
            expect(response.additional_evidence_file).to eq @file_id
            expect(response.additional_evidence_text).to eq 'additional evidence text'
            expect(response.proof_of_delivery_or_service_date_file).to eq @file_id
            expect(response.proof_of_delivery_or_service_date_text).to eq 'proof of delivery or service date text'
          end
        end

        context 'when updating inexistent dispute' do
          it 'raises an error' do
            expect { previous_sdk.disputes.put_evidence('not_found', nil) }.to raise_error(CheckoutSdk::CheckoutApiException)
          end
        end
      end

      describe '.get_evidence' do
        context 'when fetching evidence for valid dispute' do
          it 'returns evidence' do
            response = previous_sdk.disputes.get_evidence(@dispute.id)

            expect(response).not_to be nil
            expect(response.proof_of_delivery_or_service_file).to eq @file_id
            expect(response.proof_of_delivery_or_service_text).to eq 'proof of delivery or service text'
            expect(response.invoice_or_receipt_file).to eq @file_id
            expect(response.invoice_or_receipt_text).to eq 'proof of receipt text'
            expect(response.invoice_showing_distinct_transactions_file).to eq @file_id
            expect(response.invoice_showing_distinct_transactions_text).to eq 'invoice showing distinct transactions text'
            expect(response.customer_communication_file).to eq @file_id
            expect(response.customer_communication_text).to eq 'customer communication text'
            expect(response.refund_or_cancellation_policy_file).to eq @file_id
            expect(response.refund_or_cancellation_policy_text).to eq 'refund or cancellation policy text'
            expect(response.recurring_transaction_agreement_file).to eq @file_id
            expect(response.recurring_transaction_agreement_text).to eq 'recurring transaction agreement text'
            expect(response.additional_evidence_file).to eq @file_id
            expect(response.additional_evidence_text).to eq 'additional evidence text'
            expect(response.proof_of_delivery_or_service_date_file).to eq @file_id
            expect(response.proof_of_delivery_or_service_date_text).to eq 'proof of delivery or service date text'
          end
        end

        context 'when fetching inexistent dispute' do
          it 'raises an error' do
            expect { previous_sdk.disputes.get_evidence('not_found') }.to raise_error(CheckoutSdk::CheckoutApiException)
          end
        end
      end

      describe '.submit_evidence' do
        context 'when dispute has evidence attached' do
          it 'submits dispute evidence' do
            response = previous_sdk.disputes.submit_evidence(@dispute.id)

            #TODO validate 204 status
          end
        end

        context 'when submitting evidence for inexistent dispute' do
          it 'raises an error' do
            expect { previous_sdk.disputes.submit_evidence('not_found') }.to raise_error(CheckoutSdk::CheckoutApiException)
          end
        end
      end

    end

    describe '.upload_file' do
      context 'when uploading a file' do
        it 'returns http 200' do
          request = CheckoutSdk::Common::FileRequest.new
          request.file = './spec/resources/checkout.jpeg'
          request.purpose = 'dispute_evidence'

          response = previous_sdk.disputes.upload_file(request)

          expect(response).not_to be nil
          expect(response.id).not_to be nil
        end
      end
    end

    describe '.get_file_details' do
      context 'when fetching existing file' do
        subject(:file) { upload_file_previous }
        it 'returns file details' do
          response = previous_sdk.disputes.get_file_details(file.id)

          assert_response response, %w[id
                                     filename
                                     purpose
                                     size
                                     uploaded_on]
        end
      end

      context 'when fetching inexistant file' do
        it 'raises an error' do
          expect { previous_sdk.disputes.get_file_details('not_found') }
            .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.http_metadata.status_code).to eq 404 }
        end
      end
    end
  end
end

private def get_disputes_previous(from: nil, to: nil, status: nil, payment_id: nil)
  query = CheckoutSdk::Disputes::DisputesQueryFilter.new
  query.from = from unless from.nil?
  query.to = to unless to.nil?
  query.statuses = status unless status.nil?
  query.payment_id = payment_id unless payment_id.nil?

  previous_sdk.disputes.query(query)
end

private def upload_file_previous
  request = CheckoutSdk::Common::FileRequest.new
  request.file = './spec/resources/checkout.jpeg'
  request.purpose = CheckoutSdk::Common::FilePurpose::DISPUTE_EVIDENCE

  previous_sdk.disputes.upload_file(request)
end

private def there_are_disputes(response)
  sleep 10
  response.total_count > 0
end

