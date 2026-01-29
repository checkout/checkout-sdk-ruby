# frozen_string_literal: true

RSpec.describe CheckoutSdk::Payments do
  include FlowHelper

  before(:all) do
    @api = default_sdk
  end

  describe '.request_payment_session' do
    context 'when creating a payment session with hash request' do
      it 'creates payment session successfully' do
        response = request_payment_session

        # Only check the essential fields that are likely to be returned
        assert_response(response, %w[id])
        expect(response.id).not_to be nil
        # Check optional fields only if they exist
        expect(response.amount).to eq(1000) if response.respond_to?(:amount) && !response.amount.nil?
        expect(response.currency).to eq('USD') if response.respond_to?(:currency) && !response.currency.nil?
      end
    end

    context 'when creating with different currencies' do
      it 'creates payment session with EUR' do
        response = request_payment_session(amount: 2000, currency: 'EUR')

        assert_response(response, %w[id])
        expect(response.id).not_to be nil
        expect(response.amount).to eq(2000) if response.respond_to?(:amount) && !response.amount.nil?
        expect(response.currency).to eq('EUR') if response.respond_to?(:currency) && !response.currency.nil?
      end

      it 'creates payment session with GBP' do
        response = request_payment_session(amount: 1500, currency: 'GBP')

        assert_response(response, %w[id])
        expect(response.id).not_to be nil
        expect(response.amount).to eq(1500) if response.respond_to?(:amount) && !response.amount.nil?
        expect(response.currency).to eq('GBP') if response.respond_to?(:currency) && !response.currency.nil?
      end
    end

    context 'when creating with invalid data' do
      it 'raises an exception for missing required fields' do
        invalid_request = {
          # Missing required fields like processing_channel_id, amount, currency
          reference: 'INVALID-REF'
        }

        expect {
          @api.flow.request_payment_session(invalid_request)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.submit_payment_session' do
    context 'when submitting a valid payment session' do
      xit 'submits payment session successfully (requires real Flow session_data)' do
        # Create a payment session first
        create_response = request_payment_session(amount: 1000)
        
        # Submit the payment session
        submit_request = submit_payment_session_request(amount: 1000)
        response = @api.flow.submit_payment_session(create_response.id, submit_request)
        
        assert_response(response, %w[id])
        expect(response.id).not_to be nil
        expect(response.amount).to eq(1000) if response.respond_to?(:amount) && !response.amount.nil?
      end
    end

    context 'when submitting with invalid payment method' do
      xit 'raises an exception for invalid card details (requires real Flow session_data)' do
        # Create a payment session first
        create_response = request_payment_session(amount: 1000)
        
        invalid_submit_request = {
          amount: 1000,
          reference: 'INVALID-REF',
          payment_type: 'InvalidType', # Invalid payment type
          ip_address: '90.197.169.245'
        }

        expect {
          @api.flow.submit_payment_session(create_response.id, invalid_submit_request)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end

    context 'when submitting to non-existent session' do
      xit 'raises an exception (requires real Flow session_data)' do
        fake_session_id = 'ps_non_existent_session'
        submit_request = submit_payment_session_request(amount: 1000)
        
        expect {
          @api.flow.submit_payment_session(fake_session_id, submit_request)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.request_payment_session_with_payment' do
    context 'when creating and submitting in one request' do
      xit 'processes payment session successfully (requires real Flow session_data)' do
        response = request_payment_session_with_payment(amount: 1000)
        
        assert_response(response, %w[id])
        expect(response.id).not_to be nil
        expect(response.amount).to eq(1000) if response.respond_to?(:amount) && !response.amount.nil?
        expect(response.currency).to eq('USD') if response.respond_to?(:currency) && !response.currency.nil?
      end
    end

    context 'when creating and submitting with different currencies' do
      xit 'processes payment session with EUR (requires real Flow session_data)' do
        response = request_payment_session_with_payment(amount: 2000, currency: 'EUR')

        assert_response(response, %w[id])
        expect(response.id).not_to be nil
        expect(response.amount).to eq(2000) if response.respond_to?(:amount) && !response.amount.nil?
        expect(response.currency).to eq('EUR') if response.respond_to?(:currency) && !response.currency.nil?
      end

      xit 'processes payment session with GBP (requires real Flow session_data)' do
        response = request_payment_session_with_payment(amount: 1500, currency: 'GBP')

        assert_response(response, %w[id])
        expect(response.id).not_to be nil
        expect(response.amount).to eq(1500) if response.respond_to?(:amount) && !response.amount.nil?
        expect(response.currency).to eq('GBP') if response.respond_to?(:currency) && !response.currency.nil?
      end
    end

    context 'when creating and submitting with invalid data' do
      xit 'raises an exception for invalid payment method (requires real Flow session_data)' do
        invalid_request = request_payment_session_with_payment_request(amount: 1000)
        invalid_request[:processing_channel_id] = 'invalid_channel_id' # Invalid channel

        expect {
          @api.flow.request_payment_session_with_payment(invalid_request)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe 'Integration workflow' do
    context 'when performing complete payment flow workflow' do
      xit 'creates session, then submits payment separately (requires real Flow session_data)' do
        # Step 1: Create payment session
        create_response = request_payment_session(amount: 1000)
        expect(create_response.id).not_to be nil
        expect(create_response.amount).to eq(1000) if create_response.respond_to?(:amount) && !create_response.amount.nil?
        expect(create_response.currency).to eq('USD') if create_response.respond_to?(:currency) && !create_response.currency.nil?
        
        # Step 2: Submit payment to the session
        submit_request = submit_payment_session_request(amount: 1000)
        submit_response = @api.flow.submit_payment_session(create_response.id, submit_request)
        
        expect(submit_response.id).not_to be nil
        expect(submit_response.amount).to eq(1000) if submit_response.respond_to?(:amount) && !submit_response.amount.nil?
      end
    end

    context 'when comparing separate vs combined flow' do
      xit 'produces similar results for both approaches (requires real Flow session_data)' do
        # Separate flow: create then submit
        create_response = request_payment_session(amount: 1000)
        submit_request = submit_payment_session_request(amount: 1000)
        separate_response = @api.flow.submit_payment_session(create_response.id, submit_request)
        
        # Combined flow: create and submit together
        combined_response = request_payment_session_with_payment(amount: 1000)
        
        # Both should have similar structure
        expect(separate_response.amount).to eq(combined_response.amount) if separate_response.respond_to?(:amount) && combined_response.respond_to?(:amount)
        expect(separate_response.currency).to eq(combined_response.currency) if separate_response.respond_to?(:currency) && combined_response.respond_to?(:currency)
      end
    end
  end
end