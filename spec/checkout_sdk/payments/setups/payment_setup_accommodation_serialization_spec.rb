# frozen_string_literal: true

RSpec.describe 'PaymentSetupAccommodation top-level fields' do
  it 'serializes the top-level and new accommodation fields' do
    accommodation = CheckoutSdk::Payments::PaymentSetupAccommodation.new
    accommodation.name = 'Grand Hotel'
    accommodation.booking_reference = 'BR-12345'
    accommodation.check_in_date = '2026-10-01'
    accommodation.check_out_date = '2026-10-05'
    accommodation.number_of_rooms = 2
    accommodation.total_number_of_guests = 2
    accommodation.refundable = true
    accommodation.delivery_recipient = 'jane.smith@example.com'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(accommodation)

    expect(hash['name']).to eq('Grand Hotel')
    expect(hash['booking_reference']).to eq('BR-12345')
    expect(hash['check_in_date']).to eq('2026-10-01')
    expect(hash['check_out_date']).to eq('2026-10-05')
    expect(hash['number_of_rooms']).to eq(2)
    expect(hash['total_number_of_guests']).to eq(2)
    expect(hash['refundable']).to be(true)
    expect(hash['delivery_recipient']).to eq('jane.smith@example.com')
  end
end

RSpec.describe 'PaymentSetupAccommodation address and guests' do
  it 'serializes address and guests' do
    accommodation = CheckoutSdk::Payments::PaymentSetupAccommodation.new

    address = CheckoutSdk::Payments::PaymentSetupAccommodationAddress.new
    address.address_line1 = '123 High Street'
    address.city = 'London'
    address.state = 'Greater London'
    address.country = 'GB'
    address.zip = 'SW1A 1AA'
    accommodation.address = address

    guest = CheckoutSdk::Payments::PaymentSetupAccommodationGuest.new
    guest.first_name = 'Jane'
    guest.last_name = 'Smith'
    guest.date_of_birth = '1990-01-01'
    accommodation.guests = [guest]

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(accommodation)

    expect(hash['address']).to eq({ 'address_line1' => '123 High Street', 'city' => 'London',
                                    'state' => 'Greater London', 'country' => 'GB', 'zip' => 'SW1A 1AA' })
    expect(hash['guests']).to eq([{ 'first_name' => 'Jane', 'last_name' => 'Smith',
                                    'date_of_birth' => '1990-01-01' }])
  end
end

RSpec.describe 'PaymentSetupAccommodation room and the new host field' do
  it 'serializes room and host' do
    accommodation = CheckoutSdk::Payments::PaymentSetupAccommodation.new

    room = CheckoutSdk::Payments::PaymentSetupAccommodationRoom.new
    room.rate = 199.99
    room.number_of_nights = 4
    room.type = 'deluxe'
    accommodation.room = [room]

    host = CheckoutSdk::Payments::PaymentSetupAccommodationHost.new
    host.registration_date = '2015-06-01'
    host.total_reservation_count = 320
    accommodation.host = host

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(accommodation)

    expect(hash['room']).to eq([{ 'rate' => 199.99, 'number_of_nights' => 4, 'type' => 'deluxe' }])
    expect(hash['host']).to eq({ 'registration_date' => '2015-06-01', 'total_reservation_count' => 320 })
  end
end
