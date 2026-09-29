# frozen_string_literal: true

# Request-side airline and accommodation sub-tree (swagger AirlineData and AccommodationData).
#
# Ruby serializes by walking instance variables, so it emits whatever shape the caller assigned and
# uses attribute names as wire keys verbatim. That makes two things worth asserting that a typed
# SDK gets from its compiler: that the renamed keys really are renamed on the wire, and that both
# passenger cardinalities survive serialization unchanged.

RSpec.describe 'AirlineData serialization' do
  def full_airline
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
    address.country = 'US'
    passenger = CheckoutSdk::Payments::Passenger.new
    passenger.first_name = 'John'
    passenger.last_name = 'White'
    passenger.date_of_birth = '1990-05-26'
    passenger.address = address

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

    [airline, passenger]
  end

  it 'serializes the whole block with a single passenger object' do
    airline, passenger = full_airline
    airline.passenger = passenger

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(airline)

    expect(hash).to eq(
      'ticket' => { 'number' => '045-21351455613', 'issue_date' => '2023-05-20',
                    'issuing_carrier_code' => 'AI', 'travel_package_indicator' => 'B',
                    'travel_agency_name' => 'World Tours', 'travel_agency_code' => '01' },
      'passenger' => { 'first_name' => 'John', 'last_name' => 'White',
                       'date_of_birth' => '1990-05-26', 'address' => { 'country' => 'US' } },
      'flight_leg_details' => [{ 'flight_number' => '101', 'carrier_code' => 'BA',
                                 'class_of_travelling' => 'J', 'departure_date' => '2023-06-19',
                                 'departure_time' => '15:30', 'departure_airport' => 'LHR',
                                 'arrival_airport' => 'LAX', 'stop_over_code' => 'x',
                                 'fare_basis_code' => 'SPRSVR' }]
    )
  end

  it 'emits passenger as a JSON object when one passenger is assigned' do
    airline, passenger = full_airline
    airline.passenger = passenger

    body = CheckoutSdk::JsonSerializer.to_custom_hash(airline).to_json

    expect(body).to include('"passenger":{')
    expect(body).not_to include('"passenger":[')
  end

  it 'emits passenger as a JSON array when several are assigned' do
    airline, passenger = full_airline
    second = CheckoutSdk::Payments::Passenger.new
    second.first_name = 'Jane'
    airline.passenger = [passenger, second]

    body = CheckoutSdk::JsonSerializer.to_custom_hash(airline).to_json

    expect(body).to include('"passenger":[')
    expect(CheckoutSdk::JsonSerializer.to_custom_hash(airline)['passenger'].size).to eq(2)
  end

  it 'omits passenger entirely when it is never assigned' do
    airline, = full_airline

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(airline)

    # An empty array and an explicit null are both rejected with
    # processing_airline_data_0_passenger_invalid, so absence is the only safe zero-passenger form.
    expect(hash).not_to have_key('passenger')
  end

  # Key-level assertions on the serialized string, so a future rename cannot pass silently. These
  # four keys were all wrong before: class_of_travelling shipped as service_class and
  # stop_over_code as stopover_code, and neither ever reached the API.
  it 'emits the renamed flight leg keys and not the old ones' do
    airline, = full_airline

    body = CheckoutSdk::JsonSerializer.to_custom_hash(airline).to_json

    expect(body).to include('"class_of_travelling":"J"')
    expect(body).to include('"stop_over_code":"x"')
    expect(body).to include('"flight_number":"101"')
    expect(body).not_to include('service_class')
    expect(body).not_to include('stopover_code')
  end

  it 'keeps flight_number a string' do
    airline, = full_airline

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(airline)

    expect(hash['flight_leg_details'].first['flight_number']).to be_a(String)
  end
end

RSpec.describe 'AccommodationData serialization' do
  it 'serializes the whole block including both phone arrays' do
    accommodation = CheckoutSdk::Payments::AccommodationData.new
    accommodation.name = 'The Sea View Hotel'
    accommodation.booking_reference = 'HOTEL123'
    accommodation.check_in_date = '2023-06-20'
    accommodation.check_out_date = '2023-06-23'
    accommodation.state = 'FL'
    accommodation.country = 'USA'
    accommodation.city = 'Los Angeles'
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

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(accommodation)

    expect(hash).to eq(
      'name' => 'The Sea View Hotel', 'booking_reference' => 'HOTEL123',
      'check_in_date' => '2023-06-20', 'check_out_date' => '2023-06-23',
      'address' => { 'address_line1' => '123 Beach Road', 'zip' => '10001' },
      'state' => 'FL', 'country' => 'USA', 'city' => 'Los Angeles', 'number_of_rooms' => 2,
      'guests' => [{ 'first_name' => 'Jane', 'last_name' => 'Doe',
                     'date_of_birth' => '1985-07-14' }],
      'room' => [{ 'rate' => '70', 'number_of_nights_at_room_rate' => '3' }],
      'property_phone' => [{ 'country_code' => '44', 'number' => '7123456789' }],
      'customer_service_phone' => [{ 'country_code' => '44', 'number' => '7123456789' }]
    )
  end

  it 'keeps rate and number_of_nights_at_room_rate as strings' do
    room = CheckoutSdk::Payments::AccommodationRoom.new
    room.rate = '70'
    room.number_of_nights_at_room_rate = '3'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(room)

    expect(hash['rate']).to be_a(String)
    expect(hash['number_of_nights_at_room_rate']).to be_a(String)
  end

  it 'keeps state and country plain strings so "USA" survives' do
    accommodation = CheckoutSdk::Payments::AccommodationData.new
    accommodation.state = 'FL'
    accommodation.country = 'USA'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(accommodation)

    expect(hash['country']).to eq('USA')
    expect(hash['state']).to eq('FL')
  end
end

RSpec.describe 'ProcessingSettings airline and accommodation' do
  it 'serializes both sub-trees on the request processing object' do
    settings = CheckoutSdk::Payments::ProcessingSettings.new

    airline = CheckoutSdk::Payments::AirlineData.new
    ticket = CheckoutSdk::Payments::Ticket.new
    ticket.number = '045-21351455613'
    airline.ticket = ticket
    settings.airline_data = [airline]

    accommodation = CheckoutSdk::Payments::AccommodationData.new
    accommodation.name = 'The Sea View Hotel'
    settings.accommodation_data = [accommodation]

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(settings)

    expect(hash['airline_data']).to eq([{ 'ticket' => { 'number' => '045-21351455613' } }])
    expect(hash['accommodation_data']).to eq([{ 'name' => 'The Sea View Hotel' }])
  end
end
