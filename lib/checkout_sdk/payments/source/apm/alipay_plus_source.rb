# frozen_string_literal: true

module CheckoutSdk
  module Payments
    class AlipayPlusSource < PaymentSource
      # @return [AlipayPlusSource] of type {CheckoutSdk::Common::PaymentSourceType::ALIPAY_PLUS}
      def self.alipay_plus_source
        AlipayPlusSource.new CheckoutSdk::Common::PaymentSourceType::ALIPAY_PLUS
      end

      # @return [AlipayPlusSource] of type {CheckoutSdk::Common::PaymentSourceType::ALIPAY_CN}
      def self.alipay_plus_cn_source
        AlipayPlusSource.new CheckoutSdk::Common::PaymentSourceType::ALIPAY_CN
      end

      # @return [AlipayPlusSource] of type {CheckoutSdk::Common::PaymentSourceType::GCASH}
      def self.alipay_plus_gcash_source
        AlipayPlusSource.new CheckoutSdk::Common::PaymentSourceType::GCASH
      end

      # @return [AlipayPlusSource] of type {CheckoutSdk::Common::PaymentSourceType::ALIPAY_HK}
      def self.alipay_plus_hk_source
        AlipayPlusSource.new CheckoutSdk::Common::PaymentSourceType::ALIPAY_HK
      end

      # @return [AlipayPlusSource] of type {CheckoutSdk::Common::PaymentSourceType::DANA}
      def self.alipay_plus_dana_source
        AlipayPlusSource.new CheckoutSdk::Common::PaymentSourceType::DANA
      end

      # @return [AlipayPlusSource] of type {CheckoutSdk::Common::PaymentSourceType::KAKAOPAY}
      def self.alipay_plus_kakao_pay_source
        AlipayPlusSource.new CheckoutSdk::Common::PaymentSourceType::KAKAOPAY
      end

      # @return [AlipayPlusSource] of type {CheckoutSdk::Common::PaymentSourceType::TRUEMONEY}
      def self.alipay_plus_true_money_source
        AlipayPlusSource.new CheckoutSdk::Common::PaymentSourceType::TRUEMONEY
      end

      # @return [AlipayPlusSource] of type {CheckoutSdk::Common::PaymentSourceType::TNG}
      def self.alipay_plus_tng_source
        AlipayPlusSource.new CheckoutSdk::Common::PaymentSourceType::TNG
      end
    end
  end
end
