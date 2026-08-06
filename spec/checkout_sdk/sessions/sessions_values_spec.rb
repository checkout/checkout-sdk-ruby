# frozen_string_literal: true

# Spec-conformance guards for the sessions value modules.
#
# These modules hold the raw wire values sent to and returned by the API, so a typo is invisible at
# development time and only fails against the live API. Each module below is asserted against the
# exact value set defined by the Checkout.com API Reference, plus a structural guard that catches
# casing mistakes across every value module in the Sessions namespace.
RSpec.describe 'Sessions value modules' do
  # An API value is snake_case, or a single uppercase letter for the Y/N/U style codes.
  def valid_api_value
    /\A([a-z0-9_]+|[A-Z])\z/
  end

  def values_of(mod)
    mod.constants.map { |name| mod.const_get(name) }.grep(String)
  end

  context 'challenge indicator split' do
    # Module#constants does not preserve declaration order, so the constants are named explicitly.
    # This asserts both the spec order and that each constant maps to the right wire value.
    it 'exposes all nine values on the sessions module, in spec order' do
      mod = CheckoutSdk::Sessions::SessionChallengeIndicator

      expect(
        [mod::NO_PREFERENCE, mod::NO_CHALLENGE_REQUESTED, mod::CHALLENGE_REQUESTED,
         mod::CHALLENGE_REQUESTED_MANDATE, mod::LOW_VALUE, mod::TRUSTED_LISTING,
         mod::TRUSTED_LISTING_PROMPT, mod::TRANSACTION_RISK_ASSESSMENT, mod::DATA_SHARE]
      ).to eq(
        %w[no_preference no_challenge_requested challenge_requested challenge_requested_mandate
           low_value trusted_listing trusted_listing_prompt transaction_risk_assessment data_share]
      )
      expect(values_of(mod).size).to eq(9)
    end

    it 'keeps only the four base values on the shared payments module' do
      expect(values_of(CheckoutSdk::Common::ChallengeIndicator)).to contain_exactly(
        'no_preference', 'no_challenge_requested', 'challenge_requested', 'challenge_requested_mandate'
      )
    end

    it 'keeps the exemption values off the shared payments module' do
      exemptions = %w[low_value trusted_listing trusted_listing_prompt transaction_risk_assessment
                      data_share]
      shared = values_of(CheckoutSdk::Common::ChallengeIndicator)
      sessions = values_of(CheckoutSdk::Sessions::SessionChallengeIndicator)

      expect(shared & exemptions).to be_empty
      expect(sessions).to include(*exemptions)
    end

    it 'defaults SessionRequest to no_preference' do
      expect(CheckoutSdk::Sessions::SessionRequest.new.challenge_indicator).to eq('no_preference')
    end
  end

  context 'value modules match the spec' do
    it 'Category uses snake_case non_payment, not the camelCase the API rejects' do
      expect(values_of(CheckoutSdk::Sessions::Category)).to contain_exactly('payment', 'non_payment')
    end

    it 'TransactionType spells quasi_card_transaction correctly' do
      expect(CheckoutSdk::Sessions::TransactionType::QUASI_CARD_TRANSACTION)
        .to eq('quasi_card_transaction')
      expect(values_of(CheckoutSdk::Sessions::TransactionType).uniq).to contain_exactly(
        'account_funding', 'check_acceptance', 'goods_service', 'prepaid_activation_and_load',
        'quasi_card_transaction'
      )
    end

    it 'ShippingIndicator covers all seven spec values and no longer holds visa' do
      values = values_of(CheckoutSdk::Sessions::ShippingIndicator)

      expect(values).to contain_exactly(
        'billing_address', 'another_address_on_file', 'not_on_file', 'store_pick_up',
        'digital_goods', 'travel_and_event_no_shipping', 'other'
      )
      expect(values).not_to include('visa')
    end

    it 'ThreeDsMethodCompletion uses the uppercase Y/N/U the spec defines' do
      expect(values_of(CheckoutSdk::Sessions::ThreeDsMethodCompletion))
        .to contain_exactly('Y', 'N', 'U')
    end

    it 'SessionScheme covers all eight schemes' do
      expect(values_of(CheckoutSdk::Sessions::SessionScheme)).to contain_exactly(
        'visa', 'mastercard', 'jcb', 'amex', 'diners', 'cartes_bancaires', 'discover', 'upi'
      )
    end
  end

  context 'SessionRequest field set' do
    # The 24 properties of the SessionRequest schema in the API Reference. Guards both directions: a
    # spec property missing from the SDK, and an attribute the SDK declares that the spec does not.
    it 'declares exactly the spec property set' do
      expected = %w[source amount currency processing_channel_id marketplace authentication_type
                    authentication_category account_info challenge_indicator billing_descriptor
                    reference merchant_risk_info transaction_type shipping_address
                    shipping_address_matches_billing completion channel_data recurring installment
                    optimization initial_transaction device_information google_spa
                    preferred_experiences]

      declared = CheckoutSdk::Sessions::SessionRequest.public_instance_methods(false)
                                                      .map(&:to_s)
                                                      .reject { |name| name.end_with?('=') }

      expect(declared).to match_array(expected)
      expect(declared.size).to eq(24)
    end

    it 'no longer declares prior_transaction_reference, which the spec does not define' do
      expect(CheckoutSdk::Sessions::SessionRequest.public_instance_methods(false))
        .not_to include(:prior_transaction_reference)
    end

    it 'accepts google_spa and preferred_experiences' do
      google_spa = CheckoutSdk::Sessions::GoogleSpa.new
      google_spa.continue_url = 'https://merchant.com/continue'

      request = CheckoutSdk::Sessions::SessionRequest.new
      request.google_spa = google_spa
      request.preferred_experiences = [CheckoutSdk::Sessions::Experience::THREE_DS,
                                       CheckoutSdk::Sessions::Experience::GOOGLE_SPA]

      expect(request.google_spa.continue_url).to eq('https://merchant.com/continue')
      expect(request.preferred_experiences).to eq(%w[3ds google_spa])
    end

    it 'Experience matches the spec value set' do
      expect(values_of(CheckoutSdk::Sessions::Experience)).to contain_exactly('3ds', 'google_spa')
    end
  end

  context 'session model field sets' do
    def readers(klass)
      klass.public_instance_methods(false).map(&:to_s).reject { |name| name.end_with?('=') }
    end

    # The spec Browser schema has 14 properties. iframe_payment_allowed and user_agent_client_hint
    # were previously missing, so Google SPA support could not be signalled.
    it 'BrowserSession covers every spec field' do
      declared = readers(CheckoutSdk::Sessions::BrowserSession) +
                 readers(CheckoutSdk::Sessions::ChannelData)

      expect(declared).to include('iframe_payment_allowed', 'user_agent_client_hint')
      expect(declared).to match_array(
        %w[channel three_ds_method_completion accept_header java_enabled javascript_enabled language
           color_depth screen_height screen_width timezone user_agent ip_address
           iframe_payment_allowed user_agent_client_hint]
      )
    end

    # The sessions CardSource schema has no store_for_future_use; that field belongs to the payments
    # sources, which create an instrument.
    it 'CardSource does not expose store_for_future_use' do
      declared = readers(CheckoutSdk::Sessions::CardSource) +
                 readers(CheckoutSdk::Sessions::SessionSource)

      expect(declared).not_to include('store_for_future_use')
      expect(declared).to match_array(
        %w[type scheme billing_address home_phone mobile_phone work_phone email
           number expiry_month expiry_year name stored]
      )
    end

    # All 20 properties of the spec CardholderAccountInfo schema must be accessible, not merely
    # documented.
    it 'CardholderAccountInfo exposes all twenty spec properties' do
      expect(readers(CheckoutSdk::Sessions::CardholderAccountInfo).size).to eq(20)
    end
  end

  context 'structural guard' do
    # Catches camelCase or wrong casing leaking into a wire value, which is how nonPayment survived.
    it 'every sessions value is snake_case or a single uppercase code' do
      modules = [
        CheckoutSdk::Sessions::SessionChallengeIndicator,
        CheckoutSdk::Sessions::Category,
        CheckoutSdk::Sessions::TransactionType,
        CheckoutSdk::Sessions::AuthenticationType,
        CheckoutSdk::Sessions::ShippingIndicator,
        CheckoutSdk::Sessions::SessionScheme,
        CheckoutSdk::Sessions::ThreeDsMethodCompletion,
        CheckoutSdk::Sessions::AuthenticationMethod,
        CheckoutSdk::Sessions::DeliveryTimeframe,
        CheckoutSdk::Sessions::ThreeDsReqAuthMethod,
        CheckoutSdk::Sessions::SessionSourceType,
        CheckoutSdk::Sessions::Experience,
        CheckoutSdk::Common::ChallengeIndicator
      ]
      checked = modules.flat_map { |mod| values_of(mod) }

      expect(checked.size).to be > 50
      checked.each do |value|
        expect(value).to match(valid_api_value), "#{value.inspect} is not a valid API value"
      end
    end
  end
end
