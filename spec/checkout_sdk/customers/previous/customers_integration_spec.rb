RSpec.describe CheckoutSdk::Customers do
  describe 'Previous' do

    describe '.create' do
      context 'when creating a customer with valid data' do
        it 'returns a new customer' do
          request = CheckoutSdk::Customers::CustomerRequest.new
          request.email = generate_random_email
          request.name = Helpers::DataFactory::NAME
          request.phone = phone

          response = previous_sdk.customers.create(request)

          expect(response).not_to be nil
          expect(response.id).not_to be nil
          expect(response.http_metadata.status_code).to eq 201
        end
      end

      context 'when creating a customer with invalid data' do
        it 'raises an error' do
          request = CheckoutSdk::Customers::CustomerRequest.new
          request.email = 'invalid_email'

          expect { previous_sdk.customers.create(request) }.to raise_error(CheckoutSdk::CheckoutApiException)
        end
      end
    end

    describe '.get' do
      context 'when fetching a valid customer' do
        subject(:customer_id) { create_customer_previous.id }
        it 'returns customer data' do
          response = previous_sdk.customers.get(customer_id)

          expect(response).not_to be nil
          expect(response.id).to eq(customer_id)
        end
      end

      context 'when fetching inexistent customer' do
        it 'raises an error' do
          expect { previous_sdk.customers.get('not_found') }.to raise_error(CheckoutSdk::CheckoutApiException)
        end
      end
    end

    describe '.update' do
      before(:all) do
        @customer = create_customer_previous
      end
      context 'when updating a valid customer' do
        it 'should update successfully' do
          request = CheckoutSdk::Customers::CustomerRequest.new
          request.name = 'new name'

          response = previous_sdk.customers.update(@customer.id, request)

          expect(response).not_to be nil
          expect(response.http_metadata.status_code).to eq 204
        end

        it 'should have new values for updated fields' do
          response = previous_sdk.customers.get(@customer.id)

          expect(response).not_to be nil
          expect(response.id).to eq(@customer.id)
          expect(response.name).to eq('new name')
        end
      end
    end

    describe '.delete' do
      subject(:customer_id) { create_customer_previous.id }
      context 'when deleting an existent customer' do
        it 'should return http: 200' do
          response = previous_sdk.customers.delete(customer_id)

          expect(response).not_to be nil
          expect(response.http_metadata.status_code).to eq 204
        end
      end

      context 'when deleting an inexistent customer' do
        it 'raises an error' do
          expect { previous_sdk.customers.delete('not_found') }.to raise_error(CheckoutSdk::CheckoutApiException)
        end
      end
    end
  end
end

def create_customer_previous
  request = CheckoutSdk::Customers::CustomerRequest.new
  request.email = generate_random_email
  request.name = Helpers::DataFactory::NAME
  request.phone = phone

  previous_sdk.customers.create(request)
end


