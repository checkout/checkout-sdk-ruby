# frozen_string_literal: true

module CheckoutSdk
  module Issuing
    # Request body for POST /issuing/controls/control-groups.
    #
    # @!attribute description
    #   @return [String]
    # @!attribute target_id
    #   @return [String] Card / cardholder / account / profile id.
    # @!attribute fail_if
    #   @return [String] Control-group condition (e.g. "all", "any").
    # @!attribute controls
    #   @return [Array<Hash>] Array of card controls.
    class AddControlGroupRequest
      attr_accessor :description, :target_id, :fail_if, :controls
    end
  end
end
