module SessionsHelper
  def get_browser_session
    browser_session = CheckoutSdk::Sessions::BrowserSession.new
    browser_session.accept_header = 'Accept:  *.*, q=0.1'
    browser_session.java_enabled = true
    browser_session.javascript_enabled = true
    browser_session.language = 'FR-fr'
    browser_session.color_depth = '16'
    browser_session.screen_width = '1920'
    browser_session.screen_height = '1080'
    browser_session.timezone = '60'
    browser_session.user_agent = 'Mozilla/5.0 (Windows NT 10.0 Win64 x64) AppleWebKit/537.36 (KHTML, like Gecko) ' +
                                 'Chrome/69.0.3497.100 Safari/537.36 '
    browser_session.three_ds_method_completion = CheckoutSdk::Sessions::ThreeDsMethodCompletion::Y
    browser_session.ip_address = '1.12.123.255'

    browser_session
  end

  def get_app_session
    sdk_ephemeral_public_key = CheckoutSdk::Sessions::SdkEphemeralPublicKey.new
    sdk_ephemeral_public_key.kty = 'EC'
    sdk_ephemeral_public_key.crv = 'P-256'
    sdk_ephemeral_public_key.x = 'f83OJ3D2xF1Bg8vub9tLe1gHMzV76e8Tus9uPHvRVEU'
    sdk_ephemeral_public_key.y = 'x_FEzRu9m36HLN_tue659LNpXW6pCyStikYjKIWI5a0'

    app_session = CheckoutSdk::Sessions::AppSession.new
    app_session.sdk_app_id = 'dbd64fcb-c19a-4728-8849-e3d50bfdde39'
    app_session.sdk_max_timeout = 5
    app_session.sdk_encrypted_data = '{}'
    app_session.sdk_ephem_pub_key = sdk_ephemeral_public_key
    app_session.sdk_reference_number = '3DS_LOA_SDK_PPFU_020100_00007'
    app_session.sdk_transaction_id = 'b2385523-a66c-4907-ac3c-91848e8c0067'
    app_session.sdk_interface_type = CheckoutSdk::Sessions::SdkInterfaceType::BOTH
    app_session.sdk_ui_elements = [CheckoutSdk::Sessions::UIElements::SINGLE_SELECT,
                                   CheckoutSdk::Sessions::UIElements::HTML_OTHER]

    app_session
  end

  def get_merchant_initiated_session
    merchant_initiated_session = CheckoutSdk::Sessions::MerchantInitiatedSession.new
    merchant_initiated_session.request_type = CheckoutSdk::Sessions::RequestType::RECURRING_TRANSACTION
    merchant_initiated_session
  end

  def get_non_hosted_session(channel_data, authentication_category, challenge_indicator_type, transaction_type)
    billing_address = CheckoutSdk::Sessions::SessionAddress.new
    billing_address.address_line1 = 'CheckoutSdk.com'
    billing_address.address_line2 = '90 Tottenham Court Road'
    billing_address.city = 'London'
    billing_address.state = 'ENG'
    billing_address.country = CheckoutSdk::Common::Country::GB

    session_card_source = CheckoutSdk::Sessions::CardSource.new
    session_card_source.billing_address = billing_address
    session_card_source.number = visa_card.card_number
    session_card_source.expiry_month = visa_card.expiry_month
    session_card_source.expiry_year = visa_card.expiry_year
    session_card_source.name = Helpers::DataFactory::NAME
    session_card_source.email = generate_random_email
    session_card_source.home_phone = phone
    session_card_source.work_phone = phone
    session_card_source.mobile_phone = phone

    shipping_address = CheckoutSdk::Sessions::SessionAddress.new
    shipping_address.address_line1 = 'CheckoutSdk.com'
    shipping_address.address_line2 = 'ABC building'
    shipping_address.address_line3 = '14 Wells Mews'
    shipping_address.city = 'London'
    shipping_address.state = 'ENG'
    shipping_address.zip = 'W1T 4TJ'
    shipping_address.country = CheckoutSdk::Common::Country::GB

    marketplace_data = CheckoutSdk::Sessions::SessionMarketplaceData.new
    marketplace_data.sub_entity_id = 'ent_ocw5i74vowfg2edpy66izhts2u'

    billing_descriptor = CheckoutSdk::Sessions::SessionsBillingDescriptor.new
    billing_descriptor.name = 'SUPERHEROES.COM'

    non_hosted_completion_info = CheckoutSdk::Sessions::NonHostedCompletionInfo.new
    non_hosted_completion_info.callback_url = 'https://merchant.com/callback'

    session_request = CheckoutSdk::Sessions::SessionRequest.new
    session_request.source = session_card_source
    session_request.amount = 6540
    session_request.currency = CheckoutSdk::Common::Currency::USD
    session_request.processing_channel_id = 'pc_5jp2az55l3cuths25t5p3xhwru'
    session_request.marketplace = marketplace_data
    session_request.authentication_category = authentication_category
    session_request.challenge_indicator = challenge_indicator_type
    session_request.billing_descriptor = billing_descriptor
    session_request.reference = 'ORD-5023-4E89'
    session_request.transaction_type = transaction_type
    session_request.shipping_address = shipping_address
    session_request.completion = non_hosted_completion_info
    session_request.channel_data = channel_data

    session_request
  end

  def get_hosted_session
    shipping_address = CheckoutSdk::Sessions::SessionAddress.new
    shipping_address.address_line1 = 'CheckoutSdk.com'
    shipping_address.address_line2 = '90 Tottenham Court Road'
    shipping_address.city = 'London'
    shipping_address.state = 'ENG'
    shipping_address.zip = 'W1T 4TJ'
    shipping_address.country = CheckoutSdk::Common::Country::GB

    session_card_source = CheckoutSdk::Sessions::CardSource.new
    session_card_source.number = '4485040371536584'
    session_card_source.expiry_month = 1
    session_card_source.expiry_year = 2030

    hosted_completion_info = CheckoutSdk::Sessions::HostedCompletionInfo.new
    hosted_completion_info.failure_url = 'https://example.com/sessions/fail'
    hosted_completion_info.success_url = 'https://example.com/sessions/success'

    session_request = CheckoutSdk::Sessions::SessionRequest.new
    session_request.source = session_card_source
    session_request.amount = 100
    session_request.currency = CheckoutSdk::Common::Currency::USD
    session_request.processing_channel_id = 'pc_5jp2az55l3cuths25t5p3xhwru'
    session_request.authentication_type = CheckoutSdk::Sessions::AuthenticationType::REGULAR
    session_request.authentication_category = CheckoutSdk::Sessions::Category::PAYMENT
    session_request.challenge_indicator = CheckoutSdk::Common::ChallengeIndicator::NO_PREFERENCE
    session_request.reference = 'ORD-5023-4E89'
    session_request.transaction_type = CheckoutSdk::Sessions::TransactionType::GOODS_SERVICE
    session_request.shipping_address = shipping_address
    session_request.completion = hosted_completion_info

    session_request
  end

  def request_non_hosted_browser_session
    request = get_non_hosted_session get_browser_session,
                                     CheckoutSdk::Sessions::Category::PAYMENT,
                                     CheckoutSdk::Common::ChallengeIndicator::NO_PREFERENCE,
                                     CheckoutSdk::Sessions::TransactionType::GOODS_SERVICE

    oauth_sdk.sessions.request_session request
  end

  def request_non_hosted_app_session
    request = get_non_hosted_session get_app_session,
                                     CheckoutSdk::Sessions::Category::PAYMENT,
                                     CheckoutSdk::Common::ChallengeIndicator::NO_PREFERENCE,
                                     CheckoutSdk::Sessions::TransactionType::GOODS_SERVICE

    oauth_sdk.sessions.request_session request
  end
end
