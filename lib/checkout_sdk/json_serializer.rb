# frozen_string_literal: true

module CheckoutSdk
  class JsonSerializer
    KEYS_TRANSFORMATIONS = { three_ds: '3ds',
                             account_holder_type: 'account-holder-type',
                             payment_network: 'payment-network',
                             from_: 'from' }.freeze

    def self.to_custom_hash(object)
      hash = {}
      return object if object.is_a? Hash

      object.instance_variables.each do |v|
        value = object.instance_variable_get(v)
        value = serialize_by_type(value)
        hash[keys_transformation(v)] = value
      end
      hash
    end

    def self.keys_transformation(key_name)
      key = key_name.to_s.delete('@')
      return KEYS_TRANSFORMATIONS[key.to_sym] if KEYS_TRANSFORMATIONS.key?(key.to_sym)

      key
    end

    # @param [Array] input_array
    def self.serialize_array(input_array)
      aux_array = []
      input_array.map do |value|
        value = serialize_by_type(value)
        aux_array.append(value)
      end
      aux_array
    end

    # @param [Hash] input_hash
    def self.serialize_hash(input_hash)
      aux_hash = {}
      input_hash.map do |key, value|
        value = serialize_by_type(value)
        aux_hash[key] = value
      end
      aux_hash
    end

    def self.serialize_by_type(value)
      value = serialize_array(value) if value.is_a?(Array)
      value = serialize_hash(value) if value.is_a?(Hash)
      value = to_custom_hash(value) if value.class.name.start_with? CheckoutSdk.name
      value
    end
  end
end
