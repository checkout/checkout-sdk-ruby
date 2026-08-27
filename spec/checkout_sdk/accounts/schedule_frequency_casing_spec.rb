# frozen_string_literal: true

RSpec.describe CheckoutSdk::Accounts::ScheduleFrequencyType do
  # Characterization: the OpenAPI spec declares the payout schedule frequency
  # enum lowercase (weekly, daily, monthly), but this SDK has sent capitalized
  # values since the Accounts module was introduced (deef7f1), and Java shares
  # the capitalized casing while .NET, Go, PHP and Python send lowercase. Until
  # the platform confirms which casing the API canonically accepts (likely a
  # spec bug, or the API accepts both), these examples pin what the SDK sends
  # today so any change is a deliberate decision, not an accident.
  it 'serializes the capitalized frequency values the SDK has always sent' do
    expect(described_class::WEEKLY).to eq('Weekly')
    expect(described_class::DAILY).to eq('Daily')
    expect(described_class::MONTHLY).to eq('Monthly')
  end

  it 'sends the capitalized frequency in the update schedule body' do
    schedule = CheckoutSdk::Accounts::ScheduleFrequencyWeekly.new
    schedule.by_day = %w[monday]

    hash = CheckoutSdk::JsonSerializer.to_custom_hash(schedule)

    expect(hash['frequency']).to eq('Weekly')
  end
end
