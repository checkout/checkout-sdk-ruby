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
                                     settings.failure_url
                                     billing_descriptor.name
                                     billing_descriptor.city
                                     billing_descriptor.reference
                                     presentment_details.amount
                                     presentment_details.currency])
        expect(response.amount).to eq(1000)
        expect(response.currency).to eq('USD')
        expect(response.billing_descriptor.name).to eq('Checkout.com')
        expect(response.presentment_details.currency).to eq('EUR')
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
      it 'confirms a ready payment method, or returns payment_method_not_ready when none is ready' do
        create_response = create_payment_setup(amount: 1000)
        get_response = @api.payments_setups.get_payment_setup(create_response.id)
        payment_method_name = ready_payment_method_name(get_response)

        if payment_method_name.nil?
          expect_payment_method_not_ready(create_response.id, get_response)
        else
          response = @api.payments_setups.confirm_payment_setup(create_response.id, payment_method_name)

          assert_response(response, %w[id
                                       amount
                                       currency
                                       reference
                                       payment_methods])
          expect(response.id).to eq(create_response.id)
          expect(response.amount).to eq(1000)
          expect(response.currency).to eq(CheckoutSdk::Common::Currency::USD)
        end
      end
    end

    context 'when confirming with invalid payment method name' do
      it 'raises an exception' do
        # Create a payment setup first
        create_response = create_payment_setup(amount: 1000)

        fake_payment_method_name = 'invalid_payment_method'

        expect {
          @api.payments_setups.confirm_payment_setup(create_response.id, fake_payment_method_name)
        }.to raise_error(CheckoutSdk::CheckoutApiException)
      end
    end

    context 'when confirming non-existent payment setup' do
      it 'raises an exception' do
        fake_setup_id = 'ps_non_existent_id'
        fake_payment_method_name = 'klarna'

        expect {
          @api.payments_setups.confirm_payment_setup(fake_setup_id, fake_payment_method_name)
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
        
        # Step 4: Confirm a ready payment method; with none ready the API returns payment_method_not_ready
        payment_method_name = ready_payment_method_name(get_response)
        if payment_method_name.nil?
          expect_payment_method_not_ready(create_response.id, get_response)
        else
          confirm_response = @api.payments_setups.confirm_payment_setup(create_response.id, payment_method_name)
          expect(confirm_response.id).to eq(create_response.id)
          expect(confirm_response.amount).to eq(1000)
          expect(confirm_response.payment_methods).not_to be nil
        end
      end
    end
  end

  describe 'Cash App Pay, customer device and customer identity fields' do
    it 'echoes the five new customer.device fields' do
      request = create_payment_setup_request(amount: 1000, currency: 'USD')
      request[:customer][:device] = {
        locale: 'en_US',
        fingerprint: 'fp_abc123xyz',
        ipv4: '203.0.113.0',
        ipv6: '2001:db8:85a3::8a2e:370:7334',
        client: CheckoutSdk::Payments::PaymentSetupDeviceClient::WEB,
        os: CheckoutSdk::Payments::PaymentSetupDeviceOs::ANDROID
      }

      response = @api.payments_setups.create_payment_setup(request)

      device = response.customer.device
      expect(device.locale).to eq('en_US')
      expect(device.fingerprint).to eq('fp_abc123xyz')
      expect(device.ipv4).to eq('203.0.113.0')
      expect(device.ipv6).to eq('2001:db8:85a3::8a2e:370:7334')
      expect(device.client).to eq('web')
      expect(device.os).to eq('android')
    end

    it 'echoes customer id, country and tax_number' do
      request = create_payment_setup_request(amount: 1000, currency: 'USD')
      request[:customer].merge!(id: 'cus_123456789', country: 'GB', tax_number: 'GB123456789')

      response = @api.payments_setups.create_payment_setup(request)

      expect(response.customer.id).to eq('cus_123456789')
      expect(response.customer.country).to eq('GB')
      expect(response.customer.tax_number).to eq('GB123456789')
    end

    it 'returns the Cash App payment method when it is enabled on the processing channel' do
      request = create_payment_setup_request(amount: 1000, currency: 'USD')
      request[:payment_methods] = { cashapp: { initialization: 'enabled', customer_profile_sharing: true } }
      request[:customer][:device] = {
        locale: 'en_US',
        client: CheckoutSdk::Payments::PaymentSetupDeviceClient::WEB,
        os: CheckoutSdk::Payments::PaymentSetupDeviceOs::ANDROID
      }

      response = @api.payments_setups.create_payment_setup(request)

      available = Array(response.available_payment_methods)
      skip 'Cash App Pay is not enabled on the sandbox processing channel' unless available.include?('cashapp')

      fetched = @api.payments_setups.get_payment_setup(response.id)
      cashapp_response = fetched.payment_methods.cashapp
      expect(cashapp_response.status).not_to be nil
      expect(cashapp_response.initialization).to eq('enabled')
      expect(cashapp_response.customer_profile_sharing).to be(true)
    end
  end
end
