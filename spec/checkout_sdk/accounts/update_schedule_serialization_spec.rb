# frozen_string_literal: true

RSpec.describe 'Payout schedule (UpdateSchedule) serialization' do
  def serialize(object)
    CheckoutSdk::JsonSerializer.to_custom_hash(object)
  end

  it 'serializes ISV fields and payment_instrument_id when set' do
    recurrence = CheckoutSdk::Accounts::ScheduleFrequencyWeekly.new
    recurrence.by_day = %w[monday friday]

    schedule = CheckoutSdk::Accounts::UpdateSchedule.new
    schedule.enabled = true
    schedule.threshold = 100
    schedule.balance_minimum = 500
    schedule.carry_forward_enabled = true
    schedule.payment_instrument_id = 'ppi_w4jelhppmfiufdnatam37wrfc4'
    schedule.recurrence = recurrence

    hash = serialize(schedule)

    expect(hash['enabled']).to eq(true)
    expect(hash['threshold']).to eq(100)
    expect(hash['balance_minimum']).to eq(500)
    expect(hash['carry_forward_enabled']).to eq(true)
    expect(hash['payment_instrument_id']).to eq('ppi_w4jelhppmfiufdnatam37wrfc4')
    expect(hash['recurrence']['frequency']).to eq(CheckoutSdk::Accounts::ScheduleFrequencyType::WEEKLY)
    expect(hash['recurrence']['by_day']).to eq(%w[monday friday])
  end

  it 'omits ISV fields and payment_instrument_id when unset' do
    recurrence = CheckoutSdk::Accounts::ScheduleFrequencyDaily.new

    schedule = CheckoutSdk::Accounts::UpdateSchedule.new
    schedule.enabled = true
    schedule.recurrence = recurrence

    hash = serialize(schedule)

    expect(hash['enabled']).to eq(true)
    expect(hash['recurrence']['frequency']).to eq(CheckoutSdk::Accounts::ScheduleFrequencyType::DAILY)
    expect(hash).not_to have_key('balance_minimum')
    expect(hash).not_to have_key('carry_forward_enabled')
    expect(hash).not_to have_key('payment_instrument_id')
    expect(hash).not_to have_key('threshold')
  end

  it 'serializes monthly recurrence with by_month_day' do
    recurrence = CheckoutSdk::Accounts::ScheduleFrequencyMonthly.new
    recurrence.by_month_day = [1, 15]

    schedule = CheckoutSdk::Accounts::UpdateSchedule.new
    schedule.enabled = true
    schedule.recurrence = recurrence

    hash = serialize(schedule)

    expect(hash['recurrence']['frequency']).to eq(CheckoutSdk::Accounts::ScheduleFrequencyType::MONTHLY)
    expect(hash['recurrence']['by_month_day']).to eq([1, 15])
  end
end
