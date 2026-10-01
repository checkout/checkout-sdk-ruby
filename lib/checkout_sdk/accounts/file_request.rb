# frozen_string_literal: true

module CheckoutSdk
  module Accounts
    # A file to upload with {AccountsClient#upload_file} (POST /files on the Files host), sent as a
    # multipart request. The returned ID is what document front and back attributes take. Set purpose to
    # a {FilePurpose} value.
    class FileRequest < CheckoutSdk::Common::FileRequest
    end
  end
end
