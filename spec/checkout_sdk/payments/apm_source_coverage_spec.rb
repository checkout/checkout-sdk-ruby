# frozen_string_literal: true

RSpec.describe 'APM payment source coverage' do
  # Every variant PaymentRequestSource maps on its discriminator, and the ruby class
  # that carries it. Kept as an explicit table so a new variant in the specification
  # shows up here as a missing constant rather than passing silently.
  SOURCE_CLASSES = {
    'ach' => CheckoutSdk::Payments::AchSource,
    'alipay_cn' => CheckoutSdk::Payments::AlipayCnSource,
    'alipay_hk' => CheckoutSdk::Payments::AlipayHkSource,
    'alma' => CheckoutSdk::Payments::AlmaSource,
    'bacs' => CheckoutSdk::Payments::BacsSource,
    'bancontact' => CheckoutSdk::Payments::BancontactSource,
    'bizum' => CheckoutSdk::Payments::BizumSource,
    'blik' => CheckoutSdk::Payments::BlikSource,
    'dana' => CheckoutSdk::Payments::DanaSource,
    'eps' => CheckoutSdk::Payments::EPSSource,
    'fawry' => CheckoutSdk::Payments::FawrySource,
    'gcash' => CheckoutSdk::Payments::GcashSource,
    'ideal' => CheckoutSdk::Payments::IdealSource,
    'kakaopay' => CheckoutSdk::Payments::KakaopaySource,
    'knet' => CheckoutSdk::Payments::KnetSource,
    'mbway' => CheckoutSdk::Payments::MbwaySource,
    'mobilepay' => CheckoutSdk::Payments::MobilePaySource,
    'multibanco' => CheckoutSdk::Payments::MultiBancoSource,
    'octopus' => CheckoutSdk::Payments::OctopusSource,
    'p24' => CheckoutSdk::Payments::P24Source,
    'paynow' => CheckoutSdk::Payments::PayNowSource,
    'plaid' => CheckoutSdk::Payments::PlaidSource,
    'qpay' => CheckoutSdk::Payments::QPaySource,
    'sepa' => CheckoutSdk::Payments::SepaSource,
    'sequra' => CheckoutSdk::Payments::SequraSource,
    'stcpay' => CheckoutSdk::Payments::StcPaySource,
    'swish' => CheckoutSdk::Payments::SwishSource,
    'tamara' => CheckoutSdk::Payments::TamaraSource,
    'tng' => CheckoutSdk::Payments::TngSource,
    'truemoney' => CheckoutSdk::Payments::TruemoneySource,
    'twint' => CheckoutSdk::Payments::TwintSource,
    'vipps' => CheckoutSdk::Payments::VippsSource,
    'wechatpay' => CheckoutSdk::Payments::WeChatPaySource
  }.freeze

  it 'sends the exact discriminator value for every APM source' do
    actual = SOURCE_CLASSES.transform_values do |klass|
      CheckoutSdk::JsonSerializer.to_custom_hash(klass.new)['type']
    end

    expect(actual).to eq(SOURCE_CLASSES.keys.to_h { |k| [k, k] })
  end

  it 'sends alipay_plus through its own factory, which takes the type explicitly' do
    source = CheckoutSdk::Payments::AlipayPlusSource.alipay_plus_source

    expect(CheckoutSdk::JsonSerializer.to_custom_hash(source)['type']).to eq('alipay_plus')
  end

  it 'produces identical JSON from the AlipayPlusSource factories and the dedicated classes' do
    # The seven Alipay Plus wire types were already reachable through
    # AlipayPlusSource factory methods before each got its own class. Both paths must
    # stay on the wire-identical, so neither is a behaviour change.
    pairs = {
      CheckoutSdk::Payments::AlipayPlusSource.alipay_plus_cn_source =>
        CheckoutSdk::Payments::AlipayCnSource.new,
      CheckoutSdk::Payments::AlipayPlusSource.alipay_plus_hk_source =>
        CheckoutSdk::Payments::AlipayHkSource.new,
      CheckoutSdk::Payments::AlipayPlusSource.alipay_plus_dana_source =>
        CheckoutSdk::Payments::DanaSource.new,
      CheckoutSdk::Payments::AlipayPlusSource.alipay_plus_gcash_source =>
        CheckoutSdk::Payments::GcashSource.new,
      CheckoutSdk::Payments::AlipayPlusSource.alipay_plus_kakao_pay_source =>
        CheckoutSdk::Payments::KakaopaySource.new,
      CheckoutSdk::Payments::AlipayPlusSource.alipay_plus_true_money_source =>
        CheckoutSdk::Payments::TruemoneySource.new,
      CheckoutSdk::Payments::AlipayPlusSource.alipay_plus_tng_source =>
        CheckoutSdk::Payments::TngSource.new
    }

    pairs.each do |legacy, dedicated|
      expect(CheckoutSdk::JsonSerializer.to_custom_hash(legacy))
        .to eq(CheckoutSdk::JsonSerializer.to_custom_hash(dedicated))
    end
  end

  it 'names every source type it sends in Common::PaymentSourceType' do
    declared = CheckoutSdk::Common::PaymentSourceType.constants.map do |c|
      CheckoutSdk::Common::PaymentSourceType.const_get(c)
    end

    expect(declared).to include(*SOURCE_CLASSES.keys)
  end

  it 'declares the five source types that were previously absent from the enum' do
    expect(CheckoutSdk::Common::PaymentSourceType::MOBILEPAY).to eq('mobilepay')
    expect(CheckoutSdk::Common::PaymentSourceType::PAYNOW).to eq('paynow')
    expect(CheckoutSdk::Common::PaymentSourceType::SWISH).to eq('swish')
    expect(CheckoutSdk::Common::PaymentSourceType::TWINT).to eq('twint')
    expect(CheckoutSdk::Common::PaymentSourceType::VIPPS).to eq('vipps')
  end

  it 'serializes a type-only source as nothing but its type' do
    hash = CheckoutSdk::JsonSerializer.to_custom_hash(CheckoutSdk::Payments::DanaSource.new)

    expect(hash).to eq({ 'type' => 'dana' })
  end

  describe CheckoutSdk::Payments::SwishSource do
    it 'serializes payment_country, account_holder and billing_descriptor' do
      holder = CheckoutSdk::Payments::SwishAccountHolder.new
      holder.first_name = 'John'
      holder.last_name = 'Smith'

      descriptor = CheckoutSdk::Payments::SwishBillingDescriptor.new
      descriptor.name = 'Thanks for shopping'

      source = described_class.new
      source.payment_country = described_class::SWEDEN
      source.account_holder = holder
      source.billing_descriptor = descriptor

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(source)

      expect(hash['type']).to eq('swish')
      expect(hash['payment_country']).to eq('SE')
      expect(hash['account_holder']).to eq({ 'first_name' => 'John', 'last_name' => 'Smith' })
      expect(hash['billing_descriptor']).to eq({ 'name' => 'Thanks for shopping' })
      expect(hash.keys.sort).to eq(%w[account_holder billing_descriptor payment_country type])
    end

    it 'omits the optional billing_descriptor when unset' do
      source = described_class.new
      source.payment_country = described_class::SWEDEN

      expect(CheckoutSdk::JsonSerializer.to_custom_hash(source)).not_to have_key('billing_descriptor')
    end
  end

  describe CheckoutSdk::Payments::AchSourceAccountType do
    it 'declares savings, checking and cash' do
      # PaymentRequestAchSource is the only position declaring this set. The shared
      # Common::AccountType declares `current` instead of `checking` and cannot
      # express a valid ACH source account type.
      expect(described_class::SAVINGS).to eq('savings')
      expect(described_class::CHECKING).to eq('checking')
      expect(described_class::CASH).to eq('cash')

      values = described_class.constants.map { |c| described_class.const_get(c) }
      expect(values.sort).to eq(%w[cash checking savings])
    end

    it 'differs from Common::AccountType and Instruments::AchAccountType' do
      shared = CheckoutSdk::Common::AccountType.constants.map do |c|
        CheckoutSdk::Common::AccountType.const_get(c)
      end
      instrument = CheckoutSdk::Instruments::AchAccountType.constants.map do |c|
        CheckoutSdk::Instruments::AchAccountType.const_get(c)
      end

      expect(shared).not_to include('checking')
      expect(shared).to include('current')
      expect(instrument).not_to include('cash')
    end
  end

  describe CheckoutSdk::Payments::AchSource do
    it 'accepts checking, the value the shared AccountType cannot express' do
      source = described_class.new
      source.account_type = CheckoutSdk::Payments::AchSourceAccountType::CHECKING
      source.country = CheckoutSdk::Common::Country::US
      source.account_number = '136549956'
      source.bank_code = '021000021'

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(source)

      expect(hash['type']).to eq('ach')
      expect(hash['account_type']).to eq('checking')
    end
  end
end
