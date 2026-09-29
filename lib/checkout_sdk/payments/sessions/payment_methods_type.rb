# frozen_string_literal: true

module CheckoutSdk
  module Payments
    # The type of payment method that can be enabled or disabled for a payment session.
    #
    # This is a consolidated list covering every payment method the Flow API accepts for
    # enabled_payment_methods / disabled_payment_methods. Constants marked deprecated are no
    # longer part of the specification but are kept for backward compatibility.
    module PaymentMethodsType
      ALIPAY_CN = 'alipay_cn'
      ALIPAY_HK = 'alipay_hk'
      ALMA = 'alma'
      APPLEPAY = 'applepay'
      BANCONTACT = 'bancontact'
      BENEFIT = 'benefit'
      BIZUM = 'bizum'
      CARD = 'card'
      DANA = 'dana'
      EPS = 'eps'
      # @deprecated No longer part of the specification.
      GIROPAY = 'giropay'
      GCASH = 'gcash'
      GOOGLEPAY = 'googlepay'
      IDEAL = 'ideal'
      KAKAOPAY = 'kakaopay'
      KLARNA = 'klarna'
      KNET = 'knet'
      MBWAY = 'mbway'
      MOBILEPAY = 'mobilepay'
      MULTIBANCO = 'multibanco'
      OCTOPUS = 'octopus'
      PRZELEWY24 = 'p24'
      PAYNOW = 'paynow'
      PAYPAL = 'paypal'
      PLAID = 'plaid'
      QPAY = 'qpay'
      # Fully supported by the API but deliberately unlisted in the public specification, so
      # that merchants do not disable Remember Me en masse. Do not remove it as an unspecified
      # value.
      REMEMBER_ME = 'remember_me'
      SEPA = 'sepa'
      # @deprecated No longer part of the specification.
      SOFORT = 'sofort'
      STCPAY = 'stcpay'
      STORED_CARD = 'stored_card'
      TABBY = 'tabby'
      TAMARA = 'tamara'
      TNG = 'tng'
      TRUEMONEY = 'truemoney'
      TWINT = 'twint'
      VIPPS = 'vipps'
      WECHATPAY = 'wechatpay'
    end
  end
end
