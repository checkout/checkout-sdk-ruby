# frozen_string_literal: true

RSpec.describe CheckoutSdk::Payments do
  include PaymentSetupsHelper

  before(:all) do
    @api = default_sdk
  end

  describe '.create_payment_setup' do
    context 'when creating a payment setup with hash request' do
      it 'creates payment setup successfully' do
        response = create_payment_setup

        assert_response(response, %w[id
                                     amount
                                     currency
                                     reference
                                     description
                                     customer.name
                                     settings.success_url
                                     settings.failure_url])
        expect(response.amount).to eq(1000)
        expect(response.currency).to eq('USD')
      end
    end

    context 'when creating with different currencies' do
      it 'creates payment setup with EUR' do
        response = create_payment_setup(amount: 2000, currency: 'EUR')

        assert_response(response, %w[id amount currency])
        expect(response.amount).to eq(2000)
        expect(response.currency).to eq('EUR')
      end

      it 'creates payment setup with GBP' do
        response = create_payment_setup(amount: 1500, currency: 'GBP')

        assert_response(response, %w[id amount currency])
        expect(response.amount).to eq(1500)
        expect(response.currency).to eq('GBP')
      end
    end
  end

  describe '.update_payment_setup' do
    context 'when updating an existing payment setup' do
      it 'updates payment setup successfully' do
        # Create initial payment setup
        create_response = create_payment_setup(amount: 1000)
        
        # Prepare update request with modified description
        update_request = create_payment_setup_request(amount: 1000)
        update_request[:description] = 'Updated Payment Setup'
        
        # Update the payment setup
        response = @api.payments_setups.update_payment_setup(create_response.id, update_request)
        
        assert_response(response, %w[id
                                     amount
                                     currency
                                     reference
                                     description
                                     customer.name])
        expect(response.id).to eq(create_response.id)
        expect(response.description).to eq('Updated Payment Setup')
      end
    end
  end

  describe '.get_payment_setup' do
    context 'when retrieving an existing payment setup' do
      it 'returns payment setup details' do
        # Create a payment setup first
        create_response = create_payment_setup(amount: 1000)
        
        # Retrieve the payment setup
        response = @api.payments_setups.get_payment_setup(create_response.id)
        
        assert_response(response, %w[id
                                     amount
                                     currency
                                     reference
                                     description
                                     customer.name
                                     settings.success_url
                                     settings.failure_url])
        expect(response.id).to eq(create_response.id)
        expect(response.amount).to eq(1000)
        expect(response.currency).to eq(CheckoutSdk::Common::Currency::USD)
      end
    end

    context 'when retrieving non-existent payment setup' do
      it 'raises an exception' do
        fake_id = 'ps_non_existent_id'
        
        expect {
          @api.payments_setups.get_payment_setup(fake_id)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe '.confirm_payment_setup' do
    context 'when confirming a payment setup' do
      it 'confirms payment setup successfully' do
        # Create a payment setup first
        create_response = create_payment_setup(amount: 1000)
        
        # Get payment setup to obtain payment method options
        get_response = @api.payments_setups.get_payment_setup(create_response.id)
        
        # Skip if no payment method options are available (sandbox limitation)
        skip 'No payment method options available in sandbox' if get_response.payment_method_options.nil? || get_response.payment_method_options.empty?
        
        # Get the first payment method option ID
        payment_method_option_id = get_response.payment_method_options.first['id']
        
        # Confirm the payment setup
        response = @api.payments_setups.confirm_payment_setup(create_response.id, payment_method_option_id)
        
        assert_response(response, %w[id
                                     action_id
                                     amount
                                     currency
                                     status
                                     processed_on
                                     _links])
        expect(response.amount).to eq(1000)
        expect(response.currency).to eq(CheckoutSdk::Common::Currency::USD)
        expect(response.status).not_to be nil
      end
    end

    context 'when confirming with invalid payment method option' do
      it 'raises an exception' do
        # Create a payment setup first
        create_response = create_payment_setup(amount: 1000)
        
        fake_option_id = 'invalid_option_id'
        
        expect {
          @api.payments_setups.confirm_payment_setup(create_response.id, fake_option_id)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end

    context 'when confirming non-existent payment setup' do
      it 'raises an exception' do
        fake_setup_id = 'ps_non_existent_id'
        fake_option_id = 'option_id'
        
        expect {
          @api.payments_setups.confirm_payment_setup(fake_setup_id, fake_option_id)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end
  end

  describe 'Integration workflow' do
    context 'when performing complete payment setup workflow' do
      it 'creates, updates, retrieves and attempts to confirm' do
        # Step 1: Create payment setup
        create_response = create_payment_setup(amount: 1000)
        expect(create_response.id).not_to be nil
        expect(create_response.amount).to eq(1000)
        
        # Step 2: Update payment setup
        update_request = create_payment_setup_request(amount: 1000)
        update_request[:description] = 'Updated in workflow test'
        
        update_response = @api.payments_setups.update_payment_setup(create_response.id, update_request)
        expect(update_response.id).to eq(create_response.id)
        expect(update_response.description).to eq('Updated in workflow test')
        
        # Step 3: Retrieve payment setup details
        get_response = @api.payments_setups.get_payment_setup(create_response.id)
        expect(get_response.id).to eq(create_response.id)
        expect(get_response.description).to eq('Updated in workflow test')
        
        # Step 4: Attempt to confirm (might skip if no options available in sandbox)
        unless get_response.payment_method_options.nil? || get_response.payment_method_options.empty?
          payment_method_option_id = get_response.payment_method_options.first['id']
          
          confirm_response = @api.payments_setups.confirm_payment_setup(create_response.id, payment_method_option_id)
          expect(confirm_response.id).not_to be nil
          expect(confirm_response.amount).to eq(1000)
          expect(confirm_response.status).not_to be nil
        end
      end
    end
  end
end