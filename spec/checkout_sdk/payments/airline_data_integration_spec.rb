# frozen_string_literal: true

# Live coverage for the airline and accommodation processing sub-tree.
#
# The whole point of this file is that a spec-derived suite cannot catch the passenger cardinality
# inversion: the specification declares `passenger` array-only, and the live API rejects the array
# on three of four request surfaces. Only a real request shows that. See AirlineData#passenger.
RSpec.describe CheckoutSdk::Payments do
  include PaymentsHelper

  def airline_data
    airline = CheckoutSdk::Payments::AirlineData.new

    ticket = CheckoutSdk::Payments::Ticket.new
    ticket.number = '045-21351455613'
    ticket.issue_date = '2023-05-20'
    ticket.issuing_carrier_code = 'AI'
    ticket.travel_package_indicator = 'B'
    ticket.travel_agency_name = 'World Tours'
    ticket.travel_agency_code = '01'
    airline.ticket = ticket

    address = CheckoutSdk::Payments::PassengerAddress.new
    address.country = CheckoutSdk::Common::Country::US
    passenger = CheckoutSdk::Payments::Passenger.new
    passenger.first_name = 'John'
    passenger.last_name = 'White'
    passenger.date_of_birth = '1990-05-26'
    passenger.address = address
    # A single object, not an array. Accepted on every request surface; an array is accepted only
    # on POST /payments.
    airline.passenger = passenger

    leg = CheckoutSdk::Payments::FlightLegDetails.new
    leg.flight_number = '101'
    leg.carrier_code = 'BA'
    leg.class_of_travelling = 'J'
    leg.departure_date = '2023-06-19'
    leg.departure_time = '15:30'
    leg.departure_airport = 'LHR'
    leg.arrival_airport = 'LAX'
    leg.stop_over_code = 'x'
    leg.fare_basis_code = 'SPRSVR'
    airline.flight_leg_details = [leg]

    airline
  end

  def accommodation_data
    accommodation = CheckoutSdk::Payments::AccommodationData.new
    accommodation.name = 'The Sea View Hotel'
    accommodation.booking_reference = 'HOTEL123'
    accommodation.check_in_date = '2023-06-20'
    accommodation.check_out_date = '2023-06-23'
    accommodation.city = 'Los Angeles'
    accommodation.state = 'FL'
    accommodation.country = 'USA'
    accommodation.number_of_rooms = 2

    address = CheckoutSdk::Payments::AccommodationAddress.new
    address.address_line1 = '123 Beach Road'
    address.zip = '10001'
    accommodation.address = address

    guest = CheckoutSdk::Payments::AccommodationGuest.new
    guest.first_name = 'Jane'
    guest.last_name = 'Doe'
    guest.date_of_birth = '1985-07-14'
    accommodation.guests = [guest]

    room = CheckoutSdk::Payments::AccommodationRoom.new
    room.rate = '70'
    room.number_of_nights_at_room_rate = '3'
    accommodation.room = [room]

    phone = CheckoutSdk::Payments::AccommodationPhone.new
    phone.country_code = '44'
    phone.number = '7123456789'
    accommodation.property_phone = [phone]
    accommodation.customer_service_phone = [phone]

    accommodation
  end

  def payment_request_with(processing)
    request = CheckoutSdk::Payments::PaymentRequest.new
    request.source = card_source
    request.reference = SecureRandom.uuid
    request.amount = 10
    request.currency = CheckoutSdk::Common::Currency::USD
    request.capture = false
    request.customer = common_customer_request
    request.processing = processing
    request
  end

  describe '.request_payment with airline data' do
    context 'when sending a single passenger as an object' do
      it 'is accepted' do
        processing = CheckoutSdk::Payments::ProcessingSettings.new
        processing.airline_data = [airline_data]

        response = default_sdk.payments.request_payment(payment_request_with(processing))

        expect(response).not_to be nil
        expect(response.id).not_to be nil
        expect(response.approved).to be true
      end
    end

    context 'when sending two passengers as an array' do
      it 'is accepted on POST /payments, the only surface that takes the array form' do
        airline = airline_data
        second = CheckoutSdk::Payments::Passenger.new
        second.first_name = 'Jane'
        second.last_name = 'Doe'
        airline.passenger = [airline.passenger, second]

        processing = CheckoutSdk::Payments::ProcessingSettings.new
        processing.airline_data = [airline]

        response = default_sdk.payments.request_payment(payment_request_with(processing))

        expect(response).not_to be nil
        expect(response.approved).to be true
      end
    end

    context 'when sending accommodation data alongside it' do
      it 'is accepted with both phone arrays' do
        processing = CheckoutSdk::Payments::ProcessingSettings.new
        processing.airline_data = [airline_data]
        processing.accommodation_data = [accommodation_data]

        response = default_sdk.payments.request_payment(payment_request_with(processing))

        expect(response).not_to be nil
        expect(response.approved).to be true
      end
    end
  end
end
