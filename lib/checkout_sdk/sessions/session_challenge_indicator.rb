# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # Indicates whether a challenge is requested for this session.
    #
    # Used by {SessionRequest#challenge_indicator} for POST /sessions. This is the only field in the
    # API that accepts the exemption values below; the 3ds.challenge_indicator field on payments,
    # hosted payments, payment links and payment sessions accepts only the first four values and is
    # modelled by {CheckoutSdk::Common::ChallengeIndicator}.
    #
    # The following are requests for exemption: {LOW_VALUE}, {TRUSTED_LISTING},
    # {TRUSTED_LISTING_PROMPT} and {TRANSACTION_RISK_ASSESSMENT}. If an exemption cannot be applied,
    # then the value {NO_CHALLENGE_REQUESTED} will be used instead.
    #
    # [Optional]
    # Default: {NO_PREFERENCE}
    # max 50 characters
    module SessionChallengeIndicator
      NO_PREFERENCE = 'no_preference'
      NO_CHALLENGE_REQUESTED = 'no_challenge_requested'
      CHALLENGE_REQUESTED = 'challenge_requested'
      CHALLENGE_REQUESTED_MANDATE = 'challenge_requested_mandate'
      LOW_VALUE = 'low_value'
      TRUSTED_LISTING = 'trusted_listing'
      TRUSTED_LISTING_PROMPT = 'trusted_listing_prompt'
      TRANSACTION_RISK_ASSESSMENT = 'transaction_risk_assessment'
      DATA_SHARE = 'data_share'
    end
  end
end
