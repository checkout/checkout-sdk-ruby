RSpec.describe CheckoutSdk::Customers do
  describe 'Default' do

    describe '.create' do
      context 'when creating a customer with valid data' do
        it 'returns a new customer' do
          request = CheckoutSdk::Customers::CustomerRequest.new
          request.email = generate_random_email
          request.name = Helpers::DataFactory::NAME
          request.phone = phone

          response = default_sdk.customers.create(request)

          expect(response).not_to be nil
          expect(response.id).not_to be nil
          expect(response.metadata.status_code).to eq 201
        end
      end

      context 'when creating a customer with invalid data' do
        it 'raises an error' do
          request = CheckoutSdk::Customers::CustomerRequest.new
          request.email = 'invalid_email'

          expect { default_sdk.customers.create(request) }.to raise_error(CheckoutSdk::CheckoutApiException)
        end
      end
    end

    describe '.get' do
      context 'when fetching a valid customer' do
        subject(:customer_id) { create_customer.id }
        it 'returns customer data' do
          response = default_sdk.customers.get(customer_id)

          expect(response).not_to be nil
          expect(response.id).to eq(customer_id)
        end
      end

      context 'when fetching inexistent customer' do
        it 'raises an error' do
          expect { default_sdk.customers.get('not_found') }.to raise_error(CheckoutSdk::CheckoutApiException)
        end
      end
    end

    describe '.update' do
      before(:all) do
        @customer = create_customer
      end
      context 'when updating a valid customer' do
        it 'should update successfully' do
          request = CheckoutSdk::Customers::CustomerRequest.new
          request.name = 'new name'

          response = default_sdk.customers.update(@customer.id, request)

          expect(response).not_to be nil
          expect(response.metadata.status_code).to eq 204
        end

        it 'should have new values for updated fields' do
          response = default_sdk.customers.get(@customer.id)

          expect(response).not_to be nil
          expect(response.id).to eq(@customer.id)
          expect(response.name).to eq('new name')
        end
      end
    end

    describe '.delete' do
      subject(:customer_id) { create_customer.id }
      context 'when deleting an existent customer' do
        it 'should return http: 200' do
          response = default_sdk.customers.delete(customer_id)

          expect(response).not_to be nil
          expect(response.metadata.status_code).to eq 204
        end
      end

      context 'when deleting an inexistent customer' do
        it 'raises an error' do
          expect { default_sdk.customers.delete('not_found') }.to raise_error(CheckoutSdk::CheckoutApiException)
        end
      end
    end
  end
end

def create_customer
  request = CheckoutSdk::Customers::CustomerRequest.new
  request.email = generate_random_email
  request.name = Helpers::DataFactory::NAME
  request.phone = phone

  default_sdk.customers.create(request)
end

