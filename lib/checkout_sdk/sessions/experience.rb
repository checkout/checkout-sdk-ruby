# frozen_string_literal: true

module CheckoutSdk
  module Sessions
    # The authentication experience chosen for a session.
    #
    # Used by {SessionRequest#preferred_experiences}, which takes an array of these values.
    #
    # [Optional]
    module Experience
      # 3D Secure authentication. The constant is named THREE_DS because a Ruby constant cannot
      # begin with a digit; the wire value is '3ds'.
      THREE_DS = '3ds'
      # Google Secure Payment Authentication.
      GOOGLE_SPA = 'google_spa'
    end
  end
end
