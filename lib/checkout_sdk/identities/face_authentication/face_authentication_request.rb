# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module FaceAuthentication
      # Request body for POST /face-authentications.
      #
      # Realigned with the spec on 2026-09-21. This class omitted user_journey_id, which
      # FavFaceAuthentication declares and requires, and declared external_reference and
      # redirect_url, which it does not. The two invented attributes are retained rather than
      # removed, so no caller breaks, and are scheduled for removal in a future major; the API
      # ignores them.
      #
      # @!attribute applicant_id
      #   The applicant's unique identifier.
      #   [Required]
      #   ^aplt_\w+$
      #   @return [String]
      # @!attribute user_journey_id
      #   Your configuration ID.
      #   [Required]
      #   ^usj_[a-z2-7]{26}$
      #   @return [String]
      # @!attribute external_reference
      #   @deprecated Not declared by FavFaceAuthentication. Never sent by the API and ignored if
      #     supplied. Scheduled for removal in a future major.
      #   @return [String]
      # @!attribute redirect_url
      #   @deprecated Not declared by FavFaceAuthentication. The redirect URL belongs on the
      #     attempt request, not the face authentication. Scheduled for removal in a future major.
      #   @return [String]
      class FaceAuthenticationRequest
        attr_accessor :applicant_id,
                      :user_journey_id,
                      :external_reference,
                      :redirect_url
      end
    end
  end
end
