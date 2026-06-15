# frozen_string_literal: true

module CheckoutSdk
  module OnboardingSimulator
    # Client for the Onboarding Simulator API (Sandbox only).
    #
    # All endpoints require OAuth with the `accounts` scope. Calling these
    # endpoints in Production returns 404.
    class OnboardingSimulatorClient < Client
      SIMULATE = 'simulate'
      ENTITIES = 'entities'
      REQUIREMENTS_DUE = 'requirements-due'
      SCENARIOS = 'scenarios'
      STATUS = 'status'
      private_constant :SIMULATE, :ENTITIES, :REQUIREMENTS_DUE, :SCENARIOS, :STATUS

      # @param [ApiClient] api_client
      # @param [CheckoutConfiguration] configuration
      def initialize(api_client, configuration)
        super(api_client, configuration, CheckoutSdk::AuthorizationType::OAUTH)
      end

      # Marks the specified requirement fields as due on an entity.
      # @param [String] entity_id
      # @param [Hash, SimulatorSetRequirementsDueRequest] request
      def set_requirements_due(entity_id, request)
        api_client.invoke_post(
          build_path(SIMULATE, ENTITIES, entity_id, REQUIREMENTS_DUE),
          sdk_authorization,
          request
        )
      end

      # Executes a pre-defined scenario against an entity.
      # @param [String] entity_id
      # @param [String] scenario_id
      def run_scenario(entity_id, scenario_id)
        api_client.invoke_post(
          build_path(SIMULATE, ENTITIES, entity_id, SCENARIOS, scenario_id),
          sdk_authorization
        )
      end

      # Forces the entity to the specified status.
      # @param [String] entity_id
      # @param [Hash, SimulatorSetStatusRequest] request
      def set_entity_status(entity_id, request)
        api_client.invoke_post(
          build_path(SIMULATE, ENTITIES, entity_id, STATUS),
          sdk_authorization,
          request
        )
      end

      # Returns all requirement fields that can be set as due on an entity.
      def list_available_requirements
        api_client.invoke_get(
          build_path(SIMULATE, REQUIREMENTS_DUE),
          sdk_authorization
        )
      end

      # Returns all pre-defined scenarios available.
      def list_scenarios
        api_client.invoke_get(
          build_path(SIMULATE, SCENARIOS),
          sdk_authorization
        )
      end
    end
  end
end
