# frozen_string_literal: true

module IssuingHelper

  def get_issuing_api
    if @issuing_api.nil?
      @issuing_api = CheckoutSdk.builder
                                .oauth
                                .with_client_credentials(ENV['CHECKOUT_DEFAULT_OAUTH_ISSUING_CLIENT_ID'],
                                                         ENV['CHECKOUT_DEFAULT_OAUTH_ISSUING_CLIENT_SECRET'])
                                .with_scopes([CheckoutSdk::OAuthScopes::VAULT,
                                              CheckoutSdk::OAuthScopes::ISSUING_CLIENT,
                                              CheckoutSdk::OAuthScopes::ISSUING_CARD_MGMT,
                                              CheckoutSdk::OAuthScopes::ISSUING_CONTROLS_READ,
                                              CheckoutSdk::OAuthScopes::ISSUING_CONTROLS_WRITE])
                                .with_environment(CheckoutSdk::Environment::sandbox)
                                .build
    end
    @issuing_api
  end

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
end
