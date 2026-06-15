# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    class BaseInstrumentsClient < Client
      INSTRUMENTS = 'instruments'
      private_constant :INSTRUMENTS

      # @param [String] instrument_id
      def get(instrument_id)
        api_client.invoke_get(build_path(INSTRUMENTS, instrument_id), sdk_authorization)
      end

      # @param [String] instrument_id
      def delete(instrument_id)
        api_client.invoke_delete(build_path(INSTRUMENTS, instrument_id), sdk_authorization)
      end

      # Revoke a payment instrument. The instrument status is set to INVALID
      # with the reason `revoked_by_merchant`. The instrument record is
      # retained for audit purposes.
      # @param [String] instrument_id Pattern: ^(src_)[a-z0-9]{26}$
      def revoke(instrument_id)
        api_client.invoke_patch(build_path(INSTRUMENTS, instrument_id, 'revoke'),
                                sdk_authorization)
      end
    end
  end
end
