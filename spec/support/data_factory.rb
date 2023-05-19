# frozen_string_literal: true

module Helpers
  module DataFactory
    NAME = 'Integration Test'
    FIRST_NAME = 'Integration'
    LAST_NAME = 'Test'
    SUCCESS_URL = 'https://testing.checkout.com/sucess'
    FAILURE_URL = 'https://testing.checkout.com/failure'
    CARD_NUMBER = '4242424242424242'
    CVV = '100'
    EXPIRY_MONTH = 6
    EXPIRY_YEAR = 2025
    DESCRIPTION = 'Description'
    REFERENCE = 'Reference'

    # @return [CheckoutSdk::Common::Phone]
    def phone
      if @phone.nil?
        phone = CheckoutSdk::Common::Phone.new
        phone.country_code = '1'
        phone.number = '4155552671'

        @phone = phone
      end
      @phone
    end

    # @return [Hash]
    def phone_hash
      if @phone_hash.nil?
        @phone_hash = {
          'country_code' => '1',
          'number' => '4155552671'
        }
      end
      @phone_hash
    end

    # @return [CheckoutSdk::Common::Address]
    def address
      if @address.nil?
        address = CheckoutSdk::Common::Address.new
        address.address_line1 = 'CheckoutSdk.com'
        address.address_line2 = '90 Tottenham Court Road'
        address.city = 'London'
        address.state = 'London'
        address.zip = 'W1T 4TJ'
        address.country = CheckoutSdk::Common::Country::GB

        @address = address
      end
      @address
    end

    # @return [Hash]
    def address_hash
      if @address_hash.nil?
        @address_hash = {
          'address_line1' => 'CheckoutSdk.com',
          'address_line2' => '90 Tottenham Court Road',
          'city' => 'London',
          'state' => 'London',
          'zip' => 'W1T 4TJ',
          'country' => CheckoutSdk::Common::Country::GB
        }
      end
      @address_hash
    end

    # @return [String]
    def generate_random_email
      "#{rand 99_999_999}@checkout-sdk-ruby.com"
    end

    # @return [VisaCard]
    def visa_card
      @visa_card = VisaCard.new if @visa_card.nil?
      @visa_card
    end

    # @return [CheckoutSdk::Common::CustomerRequest]
    def common_customer_request
      if @common_customer_request.nil?
        customer = CheckoutSdk::Common::CustomerRequest.new
        customer.email = generate_random_email
        customer.name = NAME
        customer.phone = phone
        @common_customer_request = customer
      end
      @common_customer_request
    end

    def common_account_holder
      if @common_account_holder.nil?
        account_holder = CheckoutSdk::Common::AccountHolder.new
        account_holder.first_name = 'John'
        account_holder.last_name = 'Smith'
        account_holder.email = generate_random_email
        account_holder.date_of_birth = '01/01/1975'
        account_holder.billing_address = address
        account_holder.phone = phone
        @common_account_holder = account_holder
      end
      @common_account_holder
    end

    def payment_recipient
      if @payment_recipient.nil?
        payment_recipient = CheckoutSdk::Payments::PaymentRecipient.new
        payment_recipient.account_number = '123456789'
        payment_recipient.dob = '1985-05-18'
        payment_recipient.first_name = 'IT'
        payment_recipient.last_name = 'Testing'
        payment_recipient.zip = '12345'
        payment_recipient.country = CheckoutSdk::Common::Country::BE
        @payment_recipient = payment_recipient
      end
      @payment_recipient
    end

    class VisaCard
      attr_reader :card_number,
                  :expiry_month,
                  :expiry_year,
                  :cvv,
                  :name

      def initialize
        @card_number = '4242424242424242'
        @expiry_month = 6
        @expiry_year = 2025
        @cvv = '100'
        @name = 'Visa Card Name'
      end
    end
  end
end
