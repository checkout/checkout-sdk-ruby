# frozen_string_literal: true

module CheckoutSdk
  module Disputes
    module DisputeStatus
      WON = 'won'
      LOST = 'lost'
      EXPIRED = 'expired'
      ACCEPTED = 'accepted'
      CANCELED = 'canceled'
      RESOLVED = 'resolved'
      ARBITRATION_WON = 'arbitration_won'
      ARBITRATION_LOST = 'arbitration_lost'
      EVIDENCE_REQUIRED = 'evidence_required'
      EVIDENCE_UNDER_REVIEW = 'evidence_under_review'
      ARBITRATION_UNDER_REVIEW = 'arbitration_under_review'
    end
  end
end
