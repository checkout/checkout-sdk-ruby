# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # Status returned after submitting a requirement response.
    # While processing, the requirement is no longer retrievable via GET endpoints;
    # if validation fails downstream the requirement may reappear.
    module EntityRequirementUpdateStatus
      PROCESSING = 'processing'
    end
  end
end
