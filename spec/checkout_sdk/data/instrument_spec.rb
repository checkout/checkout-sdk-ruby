require 'spec_helper'

RSpec.describe CheckoutSdk::Instrument do
  before do
    subject.token = 'tkn'
    subject.customer = 'customer_id'
    subject.verify = false
  end

  it 'assigns instance variables' do
    expect(subject.token).to eq('tkn')
    expect(subject.customer).to eq('customer_id')
    expect(subject.verify).to eq(false)
  end

  describe '#initialize' do
    let(:instrument) { described_class.new(token: 'tkn_1', customer: 'customer_id_1', verify: true) }

    it 'assigns instance variables' do
      expect(instrument.token).to eq('tkn_1')
      expect(instrument.customer).to eq('customer_id_1')
      expect(instrument.verify).to eq(true)
    end
  end

  describe '#data' do
    it 'returns instrument data' do
      expect(subject.data).to eq({
        type: 'token',
        token: 'tkn',
        customer: 'customer_id'
      })
    end

    context 'instrument verification' do
      before do
        subject.verify = true
      end

      it 'returns data used for instrument verification' do
        expect(subject.data).to eq({
          source: {
            type: 'token',
            token: 'tkn',
          },
          amount: 0,
          currency: 'USD',
          customer: 'customer_id'
        })
      end

      context 'with other currency' do
        before do
          subject.currency = 'EUR'
        end

        it 'returns data used for instrument verification' do
          expect(subject.data).to eq({
            source: {
              type: 'token',
              token: 'tkn',
            },
            amount: 0,
            currency: 'EUR',
            customer: 'customer_id'
          })
        end
      end
    end
  end
end

