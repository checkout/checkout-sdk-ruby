# frozen_string_literal: true

module CheckoutSdk
  module Identities
    module IdentityVerification
      # Request body for POST /identity-verifications and POST /create-and-open-idv.
      #
      # @!attribute applicant_id
      #   The applicant's unique identifier.
      #   [Required]
      #   ^aplt_\w+$
      #   @return [String]
      # @!attribute user_journey_id
      #   Your configuration ID.
      #   [Optional]
      #   ^usj_[a-z2-7]{26}$
      #   @return [String]
      # @!attribute declared_data
      #   The personal details provided by the applicant. The identity verification requests take
      #   the five field IdvIdentityDeclaredData shape.
      #   [Required]
      #   @return [IdvIdentityDeclaredData]
      # @!attribute risk_labels
      #   One or more codes that provide more information about risks associated with the
      #   verification.
      #
      #   The request schema declares this readOnly field, so carrying it here is spec faithful.
      #   It cannot be sent and will be ignored by the API; read it from the response instead.
      #   [Optional]
      #   @return [Array<String>]
      # @!attribute redirect_url
      #   The URL to redirect the applicant to after the attempt. Accepted by
      #   POST /create-and-open-idv only, which opens the first attempt in the same call.
      #   [Optional]
      #   Format: uri
      #   @return [String]
      class IdentityVerificationRequest
        attr_accessor :applicant_id, :user_journey_id, :declared_data, :risk_labels, :redirect_url
      end
    end
  end
end
