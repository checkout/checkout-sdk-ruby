# frozen_string_literal: true

module CheckoutSdk
  module Instruments
    # The account configuration of a Bacs Direct Debit instrument being stored.
    #
    # @!attribute processing_channel_id
    #   @return [String] The ID of the processing channel to associate with the
    #     instrument. [Required] Pattern: ^(pc)_(\w{26})$
    class CreateBacsInstrumentAccount
      attr_accessor :processing_channel_id
    end
  end
end
