# frozen_string_literal: true

module IssuingHelper
  def get_issuing_api
    if @issuing_api.nil?
      @issuing_api = CheckoutSdk.builder
                                .oauth
                                .with_client_credentials(ENV.fetch('CHECKOUT_DEFAULT_OAUTH_ISSUING_CLIENT_ID', nil),
                                                         ENV.fetch('CHECKOUT_DEFAULT_OAUTH_ISSUING_CLIENT_SECRET', nil))
                                .with_scopes([CheckoutSdk::OAuthScopes::VAULT,
                                              CheckoutSdk::OAuthScopes::ISSUING_CLIENT,
                                              CheckoutSdk::OAuthScopes::ISSUING_CARD_MGMT,
                                              CheckoutSdk::OAuthScopes::ISSUING_CONTROLS_READ,
                                              CheckoutSdk::OAuthScopes::ISSUING_CONTROLS_WRITE])
                                .with_environment(CheckoutSdk::Environment.sandbox)
                                .build
    end
    @issuing_api
  end

  # @@return [Hash]
  def create_cardholder
    request = {
      'type' => 'individual',
      'reference' => 'X-123456-N11',
      'entity_id' => 'ent_mujh2nia2ypezmw5fo2fofk7ka',
      'first_name' => 'John',
      'middle_name' => 'Fitzgerald',
      'last_name' => 'Kennedy',
      'email' => 'john.kennedy@myemaildomain.com',
      'phone_number' => phone_hash,
      'date_of_birth' => '1985-05-15',
      'billing_address' => address_hash,
      'residency_address' => address_hash,
      'document' => {
        'type' => 'national_identity_card',
        'front_document_id' => 'file_6lbss42ezvoufcb2beo76rvwly',
        'back_document_id' => 'file_aaz5pemp6326zbuvevp6qroqu4'
      }
    }

    cardholder = get_issuing_api.issuing.create_cardholder request

    assert_response cardholder

    cardholder
  end

  # @param [String] cardholder_id
  # @param [TrueClass, FalseClass] activate
  # @return [OpenStruct]
  def create_card(cardholder_id, activate = false)
    request = {
      'type' => 'virtual',
      'cardholder_id' => cardholder_id,
      'lifetime' => {
        'unit' => 'Months',
        'value' => 6
      },
      'reference' => 'X-123456-N11',
      'card_product_id' => 'pro_3fn6pv2ikshurn36dbd3iysyha',
      'display_name' => 'JOHN KENNEDY',
      'is_single_use' => false,
      'activate_card' => activate
    }

    card = get_issuing_api.issuing.create_card request

    assert_response card

    card
  end

  def create_control(card_id)
    request = {
      'description' => 'Max spend of 500€ per week for restaurants',
      'control_type' => 'velocity_limit',
      'target_id' => card_id,
      'velocity_limit' => {
        'amount_limit' => 5000,
        'velocity_window' => {
          'type' => 'weekly'
        }
      }
    }

    control = get_issuing_api.issuing.create_control request

    assert_response control

    control
  end
end
