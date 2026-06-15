RSpec.describe CheckoutSdk::Identities::FaceAuthentication do
  skip 'Requires sandbox credentials with Face Authentication entitlement' do
    let(:client) { default_sdk.face_authentication }

    describe '#create_face_authentication' do
      it 'creates a face authentication' do
        request = CheckoutSdk::Identities::FaceAuthentication::FaceAuthenticationRequest.new
        response = client.create_face_authentication(request)
        expect(response).not_to be_nil
      end
    end

    describe '#get_face_authentication' do
      it 'retrieves a face authentication' do
        response = client.get_face_authentication(ENV['CHECKOUT_FACE_AUTH_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#anonymize_face_authentication' do
      it 'anonymizes the face authentication' do
        response = client.anonymize_face_authentication(ENV['CHECKOUT_FACE_AUTH_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#get_face_authentication_attempts' do
      it 'lists face authentication attempts' do
        response = client.get_face_authentication_attempts(ENV['CHECKOUT_FACE_AUTH_ID'])
        expect(response).not_to be_nil
      end
    end

    describe '#get_face_authentication_attempt' do
      it 'retrieves a single face authentication attempt' do
        response = client.get_face_authentication_attempt(ENV['CHECKOUT_FACE_AUTH_ID'], ENV['CHECKOUT_FACE_AUTH_ATTEMPT_ID'])
        expect(response).not_to be_nil
      end
    end
  end
end
