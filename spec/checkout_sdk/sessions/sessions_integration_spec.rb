RSpec.describe CheckoutSdk::Sessions do
  include SessionsHelper

  describe '.request_session' do
    context 'when requesting card session using browser sessions with valid parameters' do
      it 'creates a browser session' do
        browser_session = get_browser_session

        request = get_non_hosted_session browser_session,
                                         CheckoutSdk::Sessions::Category::PAYMENT,
                                         CheckoutSdk::Common::ChallengeIndicator::NO_PREFERENCE,
                                         CheckoutSdk::Sessions::TransactionType::GOODS_SERVICE

        response = oauth_sdk.sessions.request_session request

        assert_response response, %w[id
                                     session_secret]
      end
    end

    context 'when requesting card session using an app session with valid parameters' do
      it 'creates an app session' do
        app_session = get_app_session

        request = get_non_hosted_session app_session,
                                         CheckoutSdk::Sessions::Category::PAYMENT,
                                         CheckoutSdk::Common::ChallengeIndicator::NO_PREFERENCE,
                                         CheckoutSdk::Sessions::TransactionType::GOODS_SERVICE

        response = oauth_sdk.sessions.request_session request

        assert_response response, %w[id
                                     session_secret]
      end
    end

    context 'when requesting card session using merchant initiated session', skip: 'unavailable' do
      it 'creates a merchant initiated session and retrieves session details' do

        browser_session = get_merchant_initiated_session
        request = get_non_hosted_session(browser_session,
                                         CheckoutSdk::Sessions::Category::PAYMENT,
                                         CheckoutSdk::Common::ChallengeIndicator::NO_PREFERENCE,
                                         CheckoutSdk::Sessions::TransactionType::GOODS_SERVICE)

        response = oauth_sdk.sessions.request_session(request)
        assert_response(response, %w[id session_secret])

        session_id = response.id
        session_secret = response.session_secret

        response_with_id = oauth_sdk.sessions.get_session_details(session_id)
        assert_response(response_with_id, %w[id session_secret])

        response_with_secret = oauth_sdk.sessions.get_session_details(session_id, session_secret)
        assert_response(response_with_secret, %w[id])
      end
    end
  end

  describe '.get_session_details' do
    context 'when fetching existent card browser session' do
      subject(:session) { request_non_hosted_browser_session }
      it 'retrieves session details' do
        response = oauth_sdk.sessions.get_session_details session.id

        assert_response response, %w[id
                                     session_secret]
        expect(response.id).to eq session.id
        expect(response.amount).to eq session.amount
        expect(response.currency).to eq session.currency
        expect(response.completed).to eq session.completed
        expect(response.authentication_type).to eq session.authentication_type
        expect(response.session_secret).to eq session.session_secret
      end
    end

    context 'when fetching existent card app session' do
      subject(:session) { request_non_hosted_app_session }
      it 'retrieves session details' do
        response = oauth_sdk.sessions.get_session_details session.id

        assert_response response, %w[id
                                     session_secret]
        expect(response.id).to eq session.id
        expect(response.amount).to eq session.amount
        expect(response.currency).to eq session.currency
        expect(response.completed).to eq session.completed
        expect(response.authentication_type).to eq session.authentication_type
        expect(response.session_secret).to eq session.session_secret
      end
    end

    context 'when fetching inexistent session', skip: 'returns Access denied status when updating' do
      it 'raises an error' do
        expect { oauth_sdk.sessions.get_session_details 'not_found' }
          .to raise_error(CheckoutSdk::CheckoutApiException) { |e| expect(e.http_metadata.status_code).to eq 404 }
      end
    end
  end

  describe '.update_session' do
    before(:each) do
      @session = oauth_sdk.sessions.request_session get_hosted_session
    end

    context 'when updating a Card session with an ID browser session' do
      it 'updates fields correctly' do
        response = oauth_sdk.sessions.update_session @session.id, get_browser_session

        assert_response response, %w[id
                                     session_secret]
      end
    end

    context 'when updating a Card session with session secret browser session' do
      it 'updates fields correctly' do
        response = oauth_sdk.sessions.update_session @session.id, get_browser_session, @session.session_secret

        assert_response response, %w[id]
      end
    end
  end

  describe '.complete_session' do
    before(:each) do
      @session = oauth_sdk.sessions.request_session get_hosted_session
    end

    context 'when trying to complete session with pending status and without session secret' do
      it 'raises an error because of session state' do
        expect { oauth_sdk.sessions.complete_session @session.id }
          .to raise_error(CheckoutSdk::CheckoutApiException) {
            |e| expect(e.http_metadata.status_code).to eq 403
                expect(e.error_details[:error_codes].first).to eq 'update_not_allowed_due_to_state'
          }
      end
    end

    context 'when trying to complete session with pending status and with session secret' do
      it 'raises an error because of session state' do
        expect { oauth_sdk.sessions.complete_session @session.id, @session.session_secret }
          .to raise_error(CheckoutSdk::CheckoutApiException) {
            |e| expect(e.http_metadata.status_code).to eq 403
                expect(e.error_details[:error_codes].first).to eq 'update_not_allowed_due_to_state'
          }
      end
    end
  end

  describe '.update_3ds_method_completion' do
    before(:each) do
      @session = oauth_sdk.sessions.request_session get_hosted_session
    end

    context 'when updating session with 3ds method completion indicator' do
      it 'updates fields correctly' do
        three_ds_request = CheckoutSdk::Sessions::ThreeDsMethodCompletionRequest.new
        three_ds_request.three_ds_method_completion = CheckoutSdk::Sessions::ThreeDsMethodCompletion::Y

        response = oauth_sdk.sessions.update_3ds_method_completion @session.id, three_ds_request

        assert_response response, %w[id
                                     session_secret]
      end
    end

    context 'when updating session with 3ds method completion indicator and using session secret' do
      it 'updates fields correctly' do
        three_ds_request = CheckoutSdk::Sessions::ThreeDsMethodCompletionRequest.new
        three_ds_request.three_ds_method_completion = CheckoutSdk::Sessions::ThreeDsMethodCompletion::Y

        response = oauth_sdk.sessions.update_3ds_method_completion @session.id, three_ds_request, @session.session_secret

        assert_response response, %w[id]
      end
    end
  end

end
