# frozen_string_literal: true

module CheckoutSdk
  module Common
    # The type of a payment source or destination.
    #
    # This module is shared by the current API (NAS) and the previous API (ABC),
    # which is still actively maintained. These 22 values are declared by neither
    # `PaymentRequestSourceType` nor `PaymentDetailsResponseSourceType` in the
    # current specification and are **previous API (ABC) only**:
    #
    #   afterpay, alipay, applepay, baloto, bank_account, benefit, benefitpay,
    #   boleto, cvconnect, dlocal, giropay, googlepay, illicado, oxxo, pagofacil,
    #   poli, postfinance, provider_token, rapipago, sofort, tabby, trustly
    #
    # Use them only with a previous-platform client. Every other value below is
    # current-API.
    module PaymentSourceType
      CARD = 'card'
      ID = 'id'
      NETWORK_TOKEN = 'network_token'
      TOKEN = 'token'
      CUSTOMER = 'customer'
      D_LOCAL = 'dlocal'
      KLARNA = 'klarna'
      CURRENCY_ACCOUNT = 'currency_account'
      BALOTO = 'baloto'
      BOLETO = 'boleto'
      FAWRY = 'fawry'
      GIROPAY = 'giropay'
      IDEAL = 'ideal'
      OXXO = 'oxxo'
      PAGOFACIL = 'pagofacil'
      RAPIPAGO = 'rapipago'
      SOFORT = 'sofort'
      KNET = 'knet'
      QPAY = 'qpay'
      ALIPAY = 'alipay'
      PAYPAL = 'paypal'
      MULTIBANCO = 'multibanco'
      EPS = 'eps'
      POLI = 'poli'
      P24 = 'p24'
      BENEFITPAY = 'benefitpay'
      BANCONTACT = 'bancontact'
      TAMARA = 'tamara'
      PROVIDER_TOKEN = 'provider_token'
      BANK_ACCOUNT = 'bank_account'
      WECHATPAY = 'wechatpay'
      ALIPAY_HK = 'alipay_hk'
      ALIPAY_CN = 'alipay_cn'
      ALIPAY_PLUS = 'alipay_plus'
      GCASH = 'gcash'
      DANA = 'dana'
      KAKAOPAY = 'kakaopay'
      TRUEMONEY = 'truemoney'
      TNG = 'tng'
      AFTERPAY = 'afterpay'
      BENEFIT = 'benefit'
      BLIK = 'blik'
      MBWAY = 'mbway'
      POSTFINANCE = 'postfinance'
      STCPAY = 'stcpay'
      ALMA = 'alma'
      CV_CONNECT = 'cvconnect'
      TRUSTLY = 'trustly'
      ILLICADO = 'illicado'
      SEPA = 'sepa'
      ACH = 'ach'
      BACS = 'bacs'
      BIZUM = 'bizum'
      OCTOPUS = 'octopus'
      PLAID = 'plaid'
      SEQURA = 'sequra'
      MOBILEPAY = 'mobilepay'
      PAYNOW = 'paynow'
      SWISH = 'swish'
      TWINT = 'twint'
      VIPPS = 'vipps'
      TABBY = 'tabby'
      APPLEPAY = 'applepay'
      GOOGLEPAY = 'googlepay'
    end
  end
end
