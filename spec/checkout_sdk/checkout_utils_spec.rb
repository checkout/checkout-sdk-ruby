# frozen_string_literal: true

RSpec.describe CheckoutSdk::CheckoutUtils do
  describe '.loggable_path' do
    it 'keeps a plain path unchanged' do
      expect(described_class.loggable_path('payments/pay_123/captures')).to eq('payments/pay_123/captures')
    end

    it 'leaves out the query string' do
      expect(described_class.loggable_path('events?from=2026-01-01&reference=ref')).to eq('events')
    end

    it 'escapes control characters' do
      expect(described_class.loggable_path("payments/a\nb\rc\td\e")).to eq('payments/a\nb\rc\td\e')
    end

    it 'escapes unicode line separators' do
      expect(described_class.loggable_path("payments/a\u2028b\u2029c")).to eq('payments/a\u2028b\u2029c')
    end

    it 'accepts invalid byte sequences and nil' do
      expect(described_class.loggable_path("payments/\xFF\n".b)).to eq("payments/\uFFFD\\n")
      expect(described_class.loggable_path(nil)).to eq('')
    end
  end
end
