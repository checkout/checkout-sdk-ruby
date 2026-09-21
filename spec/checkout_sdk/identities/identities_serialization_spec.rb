# frozen_string_literal: true

# Part E of the 2026-09-02 swagger delta, plus the D1 split between the shared and the identity
# verification specific shapes.
RSpec.describe 'Identities serialization' do
  # Classes are referenced by their full names rather than through local constants: assigning
  # IDV = ... inside a describe block defines the constant on Object, leaking a generic name into
  # the global namespace.
  def serialize(object)
    CheckoutSdk::JsonSerializer.to_custom_hash(object)
  end

  def phone_number
    phone = CheckoutSdk::Identities::IdvPhoneNumber.new
    phone.country_code = '+33'
    phone.number = '5555550102'
    phone
  end

  def address
    addr = CheckoutSdk::Identities::IdvAddress.new
    addr.address_line1 = '123 Main Street'
    addr.city = 'London'
    addr.zip = 'SW1A 1AA'
    addr.country = 'GB'
    addr
  end

  def identity_declared_data
    declared = CheckoutSdk::Identities::IdentityVerification::IdvIdentityDeclaredData.new
    declared.name = 'Hannah Bret'
    declared.birth_date = '1994-10-15'
    declared.email = 'hannah.bret@example.com'
    declared.phone_number = phone_number
    declared.address = address
    declared
  end

  describe CheckoutSdk::Identities::IdvPhoneNumber do
    it 'serializes both properties' do
      expect(serialize(phone_number)).to eq('country_code' => '+33', 'number' => '5555550102')
    end

    # T17: the phone country code is a dialling prefix, not an ISO code, so it stays a string.
    it 'keeps the dialling prefix verbatim' do
      expect(serialize(phone_number)['country_code']).to eq('+33')
    end
  end

  describe CheckoutSdk::Identities::IdvAddress do
    it 'serializes every property' do
      addr = address
      addr.address_line2 = 'Apt 4B'
      addr.state = 'Greater London'

      expect(serialize(addr)).to eq(
        'address_line1' => '123 Main Street',
        'address_line2' => 'Apt 4B',
        'city' => 'London',
        'state' => 'Greater London',
        'zip' => 'SW1A 1AA',
        'country' => 'GB'
      )
    end
  end

  describe 'the declared data split (D1)' do
    it 'keeps the shared shape at two attributes' do
      declared = CheckoutSdk::Identities::IdentityVerification::IdvDeclaredData.new
      declared.name = 'Hannah Bret'
      declared.birth_date = '1994-10-15'

      expect(serialize(declared)).to eq('name' => 'Hannah Bret', 'birth_date' => '1994-10-15')
    end

    # The shared class is used by the address document and ID document verification requests. The
    # three identity verification only fields must not be reachable on it.
    it 'does not expose the identity verification only fields on the shared class' do
      declared = CheckoutSdk::Identities::IdentityVerification::IdvDeclaredData.new

      expect(declared).not_to respond_to(:phone_number=)
      expect(declared).not_to respond_to(:email=)
      expect(declared).not_to respond_to(:address=)
    end

    it 'inherits the shared attributes on the identity verification shape' do
      expect(CheckoutSdk::Identities::IdentityVerification::IdvIdentityDeclaredData.superclass).to eq(CheckoutSdk::Identities::IdentityVerification::IdvDeclaredData)
      expect(serialize(identity_declared_data)).to eq(
        'name' => 'Hannah Bret',
        'birth_date' => '1994-10-15',
        'email' => 'hannah.bret@example.com',
        'phone_number' => { 'country_code' => '+33', 'number' => '5555550102' },
        'address' => {
          'address_line1' => '123 Main Street',
          'city' => 'London',
          'zip' => 'SW1A 1AA',
          'country' => 'GB'
        }
      )
    end

    it 'omits unset optional attributes' do
      declared = CheckoutSdk::Identities::IdentityVerification::IdvIdentityDeclaredData.new
      declared.name = 'Hannah Bret'

      expect(serialize(declared)).to eq('name' => 'Hannah Bret')
    end
  end

  describe 'the client information split (D1)' do
    it 'keeps the face authentication shape at two attributes' do
      info = CheckoutSdk::Identities::IdentityVerification::IdvClientInformation.new
      info.pre_selected_residence_country = 'FR'
      info.pre_selected_language = 'en-US'

      expect(serialize(info)).to eq(
        'pre_selected_residence_country' => 'FR',
        'pre_selected_language' => 'en-US'
      )
    end

    # The face authentication attempt schema declares neither document field, so sending them
    # there would be a request the API rejects. The narrow class is what prevents it.
    it 'does not expose the document fields on the face authentication shape' do
      info = CheckoutSdk::Identities::IdentityVerification::IdvClientInformation.new

      expect(info).not_to respond_to(:pre_selected_document_issuing_country=)
      expect(info).not_to respond_to(:pre_selected_document_type=)
    end

    it 'adds the two identity verification only fields on the wider shape' do
      info = CheckoutSdk::Identities::IdentityVerification::IdvIdentityClientInformation.new
      info.pre_selected_residence_country = 'FR'
      info.pre_selected_language = 'en-US'
      info.pre_selected_document_issuing_country = 'GB'
      info.pre_selected_document_type = 'Travel Document'

      expect(CheckoutSdk::Identities::IdentityVerification::IdvIdentityClientInformation.superclass).to eq(CheckoutSdk::Identities::IdentityVerification::IdvClientInformation)
      expect(serialize(info)).to eq(
        'pre_selected_residence_country' => 'FR',
        'pre_selected_language' => 'en-US',
        'pre_selected_document_issuing_country' => 'GB',
        'pre_selected_document_type' => 'Travel Document'
      )
    end
  end

  describe CheckoutSdk::Identities::IdentityVerification::IdentityVerificationAttemptRequest do
    it 'serializes phone_number and the wider client information' do
      info = CheckoutSdk::Identities::IdentityVerification::IdvIdentityClientInformation.new
      info.pre_selected_document_type = 'Passport'

      req = described_class.new
      req.redirect_url = 'https://example.com/success'
      req.phone_number = phone_number
      req.client_information = info

      hash = serialize(req)
      expect(hash['redirect_url']).to eq('https://example.com/success')
      expect(hash['phone_number']).to eq('country_code' => '+33', 'number' => '5555550102')
      expect(hash['client_information']).to eq('pre_selected_document_type' => 'Passport')
    end
  end

  describe CheckoutSdk::Identities::FaceAuthentication::FaceAuthenticationAttemptRequest do
    it 'serializes phone_number and keeps the narrow client information' do
      info = CheckoutSdk::Identities::IdentityVerification::IdvClientInformation.new
      info.pre_selected_residence_country = 'FR'

      req = described_class.new
      req.redirect_url = 'https://example.com/success'
      req.phone_number = phone_number
      req.client_information = info

      hash = serialize(req)
      expect(hash['phone_number']['country_code']).to eq('+33')
      expect(hash['client_information']).to eq('pre_selected_residence_country' => 'FR')
      expect(hash['client_information']).not_to have_key('pre_selected_document_type')
    end
  end

  describe CheckoutSdk::Identities::IdentityVerification::IdentityVerificationRequest do
    it 'carries the five field identity declared data' do
      req = described_class.new
      req.applicant_id = 'aplt_tkoi5db4hryu5cei5vwoabr7we'
      req.user_journey_id = 'usj_tkoi5db4hryu5cei5vwoabr7we'
      req.declared_data = identity_declared_data

      hash = serialize(req)
      expect(hash['declared_data']['email']).to eq('hannah.bret@example.com')
      expect(hash['declared_data']['phone_number']['country_code']).to eq('+33')
      expect(hash['declared_data']['address']['country']).to eq('GB')
    end
  end

  describe CheckoutSdk::Identities::IdDocumentVerification::IdDocumentVerificationRequest do
    # The class previously declared neither of these, and declared four attributes the spec has
    # no equivalent for. The four are retained as deprecated so no caller breaks.
    it 'now declares the two attributes the spec requires' do
      req = described_class.new
      req.applicant_id = 'aplt_tkoi5db4hryu5cei5vwoabr7we'
      req.user_journey_id = 'usj_tkoi5db4hryu5cei5vwoabr7we'

      declared = CheckoutSdk::Identities::IdentityVerification::IdvDeclaredData.new
      declared.name = 'Hannah Bret'
      declared.birth_date = '1994-10-15'
      req.declared_data = declared

      hash = serialize(req)
      expect(hash['applicant_id']).to eq('aplt_tkoi5db4hryu5cei5vwoabr7we')
      expect(hash['user_journey_id']).to eq('usj_tkoi5db4hryu5cei5vwoabr7we')
      expect(hash['declared_data']).to eq('name' => 'Hannah Bret', 'birth_date' => '1994-10-15')
    end

    it 'still responds to the four attributes the spec does not declare' do
      req = described_class.new

      expect(req).to respond_to(:external_reference=)
      expect(req).to respond_to(:document_type=)
      expect(req).to respond_to(:country=)
      expect(req).to respond_to(:redirect_url=)
    end
  end

  describe CheckoutSdk::Identities::FaceAuthentication::FaceAuthenticationRequest do
    # The class omitted user_journey_id, which FavFaceAuthentication requires, and declared two
    # attributes the spec has no equivalent for. The two are retained as deprecated.
    it 'now declares the two attributes the spec requires' do
      req = described_class.new
      req.applicant_id = 'aplt_tkoi5db4hryu5cei5vwoabr7we'
      req.user_journey_id = 'usj_tkoi5db4hryu5cei5vwoabr7we'

      expect(serialize(req)).to eq(
        'applicant_id' => 'aplt_tkoi5db4hryu5cei5vwoabr7we',
        'user_journey_id' => 'usj_tkoi5db4hryu5cei5vwoabr7we'
      )
    end

    it 'still responds to the two attributes the spec does not declare' do
      req = described_class.new

      expect(req).to respond_to(:external_reference=)
      expect(req).to respond_to(:redirect_url=)
    end
  end

  describe CheckoutSdk::Identities::AddressDocumentVerification::AddressDocumentVerificationRequest do
    it 'takes the narrow declared data shape' do
      declared = CheckoutSdk::Identities::IdentityVerification::IdvDeclaredData.new
      declared.name = 'Hannah Bret'
      declared.birth_date = '1994-10-15'

      req = described_class.new
      req.applicant_id = 'aplt_tkoi5db4hryu5cei5vwoabr7we'
      req.user_journey_id = 'usj_tkoi5db4hryu5cei5vwoabr7we'
      req.declared_data = declared

      expect(serialize(req)['declared_data']).to eq(
        'name' => 'Hannah Bret', 'birth_date' => '1994-10-15'
      )
    end
  end
end
