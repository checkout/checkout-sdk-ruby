# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # A file to upload with {AccountsClient#upload_file} (POST /files on the Files host), sent as a
    # multipart request. The returned ID is what document front and back attributes take.
    #
    # The Files host POST /files is not in the API reference: the POST /files it documents is the disputes
    # upload on the API host (purpose dispute_evidence or arbitration_evidence). For onboarding, set
    # purpose to one of the PlatformsFileUpload purposes the API reference lists for the sub-entity upload
    # (POST /entities/{entityId}/files), available as {FilePurpose} values.
    class FileRequest < CheckoutSdk::Common::FileRequest
    end
  end
end
