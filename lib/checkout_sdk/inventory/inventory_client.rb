# frozen_string_literal: true

module CheckoutSdk
  module Inventory
    # Client for the Inventory API: stock levels, atomic multi-variant reservations
    # (hold/commit/release), stock adjustments, and per-variant "product knowledge"
    # merchandising metadata for AI agents.
    #
    # All 10 operations require OAuth with the agentic:inventory scope (see
    # {CheckoutSdk::OAuthScopes::AGENTIC_INVENTORY}); unlike most domains in this SDK, there is
    # no ApiSecretKey/ApiPublicKey fallback, so this client always authorizes with
    # {CheckoutSdk::AuthorizationType::OAUTH} (the same pattern already used by
    # {CheckoutSdk::Payments::GooglePayClient}).
    #
    # Responses are returned as Hash (OpenStruct), per this SDK's convention (see e.g.
    # {CheckoutSdk::Balances::BalancesClient}); there are no typed InventoryLevels,
    # InventoryReservation or InventoryProductKnowledge response classes. Error responses
    # (404/409/422) surface as {CheckoutSdk::CheckoutApiException}; this SDK has no per-domain
    # typed error response classes, so `InventoryErrorResponse`'s fields
    # (request_id, error_type, error_codes, variant_id, available) are available generically via
    # `error.error_details`, the same as every other domain.
    #
    # getInventoryProduct, setInventoryProduct and deleteInventoryProduct are marked Beta in the
    # specification.
    class InventoryClient < Client
      INVENTORY = 'inventory'
      ADJUSTMENTS = 'adjustments'
      RESERVATIONS = 'reservations'
      COMMIT = 'commit'
      RELEASE = 'release'
      PRODUCT = 'product'
      private_constant :INVENTORY, :ADJUSTMENTS, :RESERVATIONS, :COMMIT, :RELEASE, :PRODUCT

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::OAUTH)
      end

      # Apply a signed stock adjustment to a variant's on_hand quantity, recording the reason in
      # the ledger. Returns 201, or 200 with a Cache-Control response header on an idempotent
      # replay; both share the InventoryLevels response schema.
      #
      # @param [Hash, InventoryAdjustmentRequest] adjustment_request
      # @param [String, nil] idempotency_key Optional. Cko-Idempotency-Key request header.
      # @return [Hash] the InventoryLevels response
      def adjust_inventory(adjustment_request, idempotency_key = nil)
        api_client.invoke_post(
          build_path(INVENTORY, ADJUSTMENTS),
          sdk_authorization,
          adjustment_request,
          idempotency_key
        )
      end

      # Create an atomic multi-variant hold. Returns 201, or 200 with a Cache-Control response
      # header on an idempotent replay; both share the InventoryReservation response schema.
      #
      # @param [Hash, InventoryReservationRequest] reservation_request
      # @param [String, nil] idempotency_key Optional. Cko-Idempotency-Key request header.
      # @return [Hash] the InventoryReservation response
      def create_inventory_reservation(reservation_request, idempotency_key = nil)
        api_client.invoke_post(
          build_path(INVENTORY, RESERVATIONS),
          sdk_authorization,
          reservation_request,
          idempotency_key
        )
      end

      # Retrieve a reservation by ID.
      #
      # @param [String] reservation_id
      # @return [Hash] the InventoryReservation response
      def get_inventory_reservation(reservation_id)
        api_client.invoke_get(build_path(INVENTORY, RESERVATIONS, reservation_id), sdk_authorization)
      end

      # Commit a held reservation, converting the hold into a permanent deduction. Takes no
      # request body.
      #
      # @param [String] reservation_id
      # @return [Hash] the InventoryReservation response
      def commit_inventory_reservation(reservation_id)
        api_client.invoke_post(
          build_path(INVENTORY, RESERVATIONS, reservation_id, COMMIT),
          sdk_authorization
        )
      end

      # Release a held reservation, returning the reserved quantity to available stock. Takes
      # no request body.
      #
      # @param [String] reservation_id
      # @return [Hash] the InventoryReservation response
      def release_inventory_reservation(reservation_id)
        api_client.invoke_post(
          build_path(INVENTORY, RESERVATIONS, reservation_id, RELEASE),
          sdk_authorization
        )
      end

      # Retrieve the stock levels for a variant.
      #
      # @param [String] variant_id
      # @param [Boolean, nil] expand_product Optional. When true, adds `?expand=product` so the
      #   response embeds the variant's InventoryProductKnowledge (when it exists) under
      #   `product`.
      # @return [Hash] the InventoryLevels response
      def get_inventory_levels(variant_id, expand_product: false)
        params = { expand: 'product' } if expand_product
        api_client.invoke_get(build_path(INVENTORY, variant_id), sdk_authorization, params)
      end

      # Create or replace the stock levels for a variant.
      #
      # @param [String] variant_id
      # @param [Hash, InventorySetLevelsRequest] set_levels_request
      # @return [Hash] the InventoryLevels response
      def set_inventory_levels(variant_id, set_levels_request)
        api_client.invoke_put(build_path(INVENTORY, variant_id), sdk_authorization, set_levels_request)
      end

      # Retrieve the product knowledge (merchandising metadata) for a variant. Beta.
      #
      # @param [String] variant_id
      # @return [Hash] the InventoryProductKnowledge response
      def get_inventory_product(variant_id)
        api_client.invoke_get(build_path(INVENTORY, variant_id, PRODUCT), sdk_authorization)
      end

      # Create or replace the product knowledge for a variant. Beta.
      #
      # @param [String] variant_id
      # @param [Hash, InventorySetProductRequest] set_product_request
      # @return [Hash] the InventoryProductKnowledge response
      def set_inventory_product(variant_id, set_product_request)
        api_client.invoke_put(build_path(INVENTORY, variant_id, PRODUCT), sdk_authorization, set_product_request)
      end

      # Delete the product knowledge for a variant. Beta. Returns 204 with no body.
      #
      # @param [String] variant_id
      def delete_inventory_product(variant_id)
        api_client.invoke_delete(build_path(INVENTORY, variant_id, PRODUCT), sdk_authorization)
      end
    end
  end
end
