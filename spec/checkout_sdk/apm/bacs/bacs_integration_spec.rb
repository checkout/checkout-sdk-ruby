# frozen_string_literal: true

RSpec.describe CheckoutSdk::Apm::BacsClient do
  def notification_request(source_id)
    request = CheckoutSdk::Apm::BacsNotificationRequest.new
    request.source_id = source_id
    request.notification_type = CheckoutSdk::Apm::BacsNotificationType::ADVANCE_NOTICE
    request.collection_date = '2027-07-15'
    request.amount = 4999
    request.currency = CheckoutSdk::Common::Currency::GBP
    request.reference = 'INV-12345'
    request.customer_email = 'customer@example.com'
    request.billing_descriptor = 'CHECKOUT'
    request.support_email = 'support@test.com'
    request.support_phone = '+447700900123'
    request
  end

  def bacs_instrument_request
    address = CheckoutSdk::Instruments::CreateBacsBillingAddress.new
    address.address_line1 = 'Cloverfield St.'
    address.address_line2 = '23A'
    address.city = 'London'
    address.zip = 'SW1A 1AA'
    address.country = CheckoutSdk::Common::Country::GB

    holder = CheckoutSdk::Instruments::CreateBacsAccountHolder.new
    holder.first_name = 'John'
    holder.last_name = 'Smith'
    holder.billing_address = address

    account = CheckoutSdk::Instruments::CreateBacsInstrumentAccount.new
    account.processing_channel_id = ENV.fetch('CHECKOUT_PROCESSING_CHANNEL_ID', nil)

    data = CheckoutSdk::Instruments::CreateBacsInstrumentData.new
    data.account_number = '86753246'
    data.bank_code = '040004'
    data.country = CheckoutSdk::Common::Country::GB
    data.currency = CheckoutSdk::Common::Currency::GBP
    data.payment_type = CheckoutSdk::Instruments::BacsPaymentType::RECURRING
    data.allow_partial_match = true

    request = CheckoutSdk::Instruments::InstrumentBacs.new
    request.account = account
    request.instrument_data = data
    request.account_holder = holder
    request
  end

  describe '.send_notification',
           skip: 'requires a merchant enabled for Bacs Direct Debit and an existing Bacs instrument' do
    it 'sends a pre-notification for a stored Bacs instrument' do
      instrument = default_sdk.instruments.create(bacs_instrument_request)

      response = default_sdk.bacs.send_notification(notification_request(instrument.id))

      expect(response).not_to be nil
      expect(response.event_id).not_to be nil
    end
  end

  describe 'validation' do
    it 'raises a ValidationError for an empty notification request' do
      expect do
        default_sdk.bacs.send_notification(CheckoutSdk::Apm::BacsNotificationRequest.new)
      end.to raise_error(CheckoutSdk::CheckoutApiException)
    end
  end
end
