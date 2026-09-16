# frozen_string_literal: true

RSpec.describe 'PaymentSetupAirline top-level fields' do
  it 'serializes the new top-level airline fields' do
    airline = CheckoutSdk::Payments::PaymentSetupAirline.new
    airline.total_number_of_passengers = 1
    airline.travel_type = 'international'
    airline.trip_type = 'round_trip'
    airline.refundable = false
    airline.delivery_recipient = 'jane.smith@example.com'
    airline.ancillaries = 'extra_baggage'

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(airline)

    expect(hash['total_number_of_passengers']).to eq(1)
    expect(hash['travel_type']).to eq('international')
    expect(hash['trip_type']).to eq('round_trip')
    expect(hash['refundable']).to be(false)
    expect(hash['delivery_recipient']).to eq('jane.smith@example.com')
    expect(hash['ancillaries']).to eq('extra_baggage')
  end
end

RSpec.describe 'PaymentSetupAirline ticket and passengers' do
  it 'serializes ticket and passengers' do
    airline = CheckoutSdk::Payments::PaymentSetupAirline.new

    ticket = CheckoutSdk::Payments::PaymentSetupAirlineTicket.new
    ticket.number = '1234567890'
    ticket.issuing_carrier_code = 'BA'
    ticket.travel_package_indicator = 'A'
    airline.ticket = ticket

    passenger_address = CheckoutSdk::Payments::PaymentSetupAirlinePassengerAddress.new
    passenger_address.country = 'GB'
    passenger = CheckoutSdk::Payments::PaymentSetupAirlinePassenger.new
    passenger.first_name = 'Jane'
    passenger.address = passenger_address
    airline.passengers = [passenger]

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(airline)

    expect(hash['ticket']['number']).to eq('1234567890')
    expect(hash['passengers']).to eq([{ 'first_name' => 'Jane', 'address' => { 'country' => 'GB' } }])
  end
end

RSpec.describe 'PaymentSetupAirline flight_leg_details' do
  it 'serializes the flight_leg_details array (unchanged shared schema)' do
    airline = CheckoutSdk::Payments::PaymentSetupAirline.new

    flight_leg = CheckoutSdk::Payments::FlightLegDetails.new
    flight_leg.flight_number = 100
    flight_leg.carrier_code = 'BA'
    airline.flight_leg_details = [flight_leg]

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(airline)

    expect(hash['flight_leg_details']).to eq([{ 'flight_number' => 100, 'carrier_code' => 'BA' }])
  end
end

RSpec.describe 'PaymentSetupAirline new insurance field' do
  it 'serializes insurance' do
    airline = CheckoutSdk::Payments::PaymentSetupAirline.new

    price = CheckoutSdk::Payments::PaymentSetupAirlineInsurancePrice.new
    price.amount = 25.5
    price.currency = 'GBP'
    insurance = CheckoutSdk::Payments::PaymentSetupAirlineInsurance.new
    insurance.type = 'travel'
    insurance.company = 'Acme Insurance'
    insurance.price = price
    airline.insurance = insurance

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(airline)

    expect(hash['insurance']).to eq({ 'type' => 'travel', 'company' => 'Acme Insurance',
                                      'price' => { 'amount' => 25.5, 'currency' => 'GBP' } })
  end
end
