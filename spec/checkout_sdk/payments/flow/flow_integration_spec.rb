# frozen_string_literal: true

RSpec.describe CheckoutSdk::Payments do
  include FlowHelper

  before(:all) do
    @api = default_sdk
  end

  describe '.create_payment_session' do
    context 'when creating a payment session with hash request' do
      it 'creates payment session successfully' do
        response = create_payment_session

        assert_response(response, %w[id
                                     amount
                                     currency
                                     reference
                                     description
                                     customer.name
                                     customer.email.address
                                     success_url
                                     failure_url])
        expect(response.amount).to eq(1000)
        expect(response.currency).to eq('USD')
      end
    end

    context 'when creating with different currencies' do
      it 'creates payment session with EUR' do
        response = create_payment_session(amount: 2000, currency: 'EUR')

        assert_response(response, %w[id amount currency])
        expect(response.amount).to eq(2000)
        expect(response.currency).to eq('EUR')
      end

      it 'creates payment session with GBP' do
        response = create_payment_session(amount: 1500, currency: 'GBP')

        assert_response(response, %w[id amount currency])
        expect(response.amount).to eq(1500)
        expect(response.currency).to eq('GBP')
      end
    end

    context 'when creating with invalid data' do
      it 'raises an exception for missing required fields' do
        invalid_request = {
          # Missing required fields like processing_channel_id, amount, currency
          reference: 'INVALID-REF'
        }

        expect {
          @api.flow.create_payment_session(invalid_request)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.submit_payment_session' do
    context 'when submitting a valid payment session' do
      it 'submits payment session successfully' do
        # Create a payment session first
        create_response = create_payment_session(amount: 1000)
        
        # Submit the payment session
        submit_request = submit_payment_session_request(payment_method_type: 'card')
        response = @api.flow.submit_payment_session(create_response.id, submit_request)
        
        assert_response(response, %w[id
                                     amount
                                     currency
                                     status])
        expect(response.amount).to eq(1000)
        expect(response.status).not_to be nil
      end
    end

    context 'when submitting with invalid payment method' do
      it 'raises an exception for invalid card details' do
        # Create a payment session first
        create_response = create_payment_session(amount: 1000)
        
        invalid_submit_request = {
          payment_method: {
            type: 'card',
            number: '1234567890123456', # Invalid card number
            expiry_month: 12,
            expiry_year: 2025,
            cvv: '100'
          }
        }

        expect {
          @api.flow.submit_payment_session(create_response.id, invalid_submit_request)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end

    context 'when submitting to non-existent session' do
      it 'raises an exception' do
        fake_session_id = 'ps_non_existent_session'
        submit_request = submit_payment_session_request(payment_method_type: 'card')
        
        expect {
          @api.flow.submit_payment_session(fake_session_id, submit_request)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.create_and_submit_payment_session' do
    context 'when creating and submitting in one request' do
      it 'processes payment session successfully' do
        response = create_and_submit_payment_session(amount: 1000)
        
        assert_response(response, %w[id
                                     amount
                                     currency
                                     status])
        expect(response.amount).to eq(1000)
        expect(response.currency).to eq('USD')
        expect(response.status).not_to be nil
      end
    end

    context 'when creating and submitting with different currencies' do
      it 'processes payment session with EUR' do
        response = create_and_submit_payment_session(amount: 2000, currency: 'EUR')

        assert_response(response, %w[id amount currency status])
        expect(response.amount).to eq(2000)
        expect(response.currency).to eq('EUR')
        expect(response.status).not_to be nil
      end

      it 'processes payment session with GBP' do
        response = create_and_submit_payment_session(amount: 1500, currency: 'GBP')

        assert_response(response, %w[id amount currency status])
        expect(response.amount).to eq(1500)
        expect(response.currency).to eq('GBP')
        expect(response.status).not_to be nil
      end
    end

    context 'when creating and submitting with invalid data' do
      it 'raises an exception for invalid payment method' do
        invalid_request = create_and_submit_payment_session_request(amount: 1000)
        invalid_request[:payment_method][:number] = '1234567890123456' # Invalid card

        expect {
          @api.flow.create_and_submit_payment_session(invalid_request)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe 'Integration workflow' do
    context 'when performing complete payment flow workflow' do
      it 'creates session, then submits payment separately' do
        # Step 1: Create payment session
        create_response = create_payment_session(amount: 1000)
        expect(create_response.id).not_to be nil
        expect(create_response.amount).to eq(1000)
        expect(create_response.currency).to eq('USD')
        
        # Step 2: Submit payment to the session
        submit_request = submit_payment_session_request(payment_method_type: 'card')
        submit_response = @api.flow.submit_payment_session(create_response.id, submit_request)
        
        expect(submit_response.id).not_to be nil
        expect(submit_response.amount).to eq(1000)
        expect(submit_response.status).not_to be nil
      end
    end

    context 'when comparing separate vs combined flow' do
      it 'produces similar results for both approaches' do
        # Separate flow: create then submit
        create_response = create_payment_session(amount: 1000)
        submit_request = submit_payment_session_request(payment_method_type: 'card')
        separate_response = @api.flow.submit_payment_session(create_response.id, submit_request)
        
        # Combined flow: create and submit together
        combined_response = create_and_submit_payment_session(amount: 1000)
        
        # Both should have similar structure
        expect(separate_response.amount).to eq(combined_response.amount)
        expect(separate_response.currency).to eq(combined_response.currency)
        expect(separate_response.status).not_to be nil
        expect(combined_response.status).not_to be nil
      end
    end
  end
end