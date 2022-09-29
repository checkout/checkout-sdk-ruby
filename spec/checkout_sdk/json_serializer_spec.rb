RSpec.describe CheckoutSdk::JsonSerializer do
  string = 'string'
  number = 100
  bool = true

  simple_array = [1, 2, 3, 4]
  simple_hash = { 'one' => 1, 'two' => 2 }

  context 'serialize tests' do
    it 'should parse simple checkout object into correct hash' do
      object = CheckoutSdk::TestObject.new
      object.string_attr = string
      object.number_attr = number
      object.bool_attr = bool
      object.nil_attr = nil
      object.array_attr = simple_array
      object.hash_attr = simple_hash

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(object)

      expect(hash).not_to be nil
      expect(hash.class).to eq(Hash)
      expect(hash['string_attr']).to eq(string)
      expect(hash['number_attr']).to eq(number)
      expect(hash['bool_attr']).to eq(bool)
      expect(hash['nil_attr']).to eq(nil)
      expect(hash['array_attr']).to eq(simple_array)
      expect(hash['hash_attr']).to eq(simple_hash)
    end

    it 'should parse array of hashes into correct hash' do
      object = CheckoutSdk::TestObject.new
      object.array_attr = [simple_hash, simple_hash]

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(object)

      expect(hash).not_to be nil
      expect(hash.class).to eq(Hash)
      expect(hash['array_attr']).not_to be nil
      hash['array_attr'].each do |v|
        expect(v).to eq(simple_hash)
      end
    end

    it 'should parse hash of arrays into correct hash' do
      object = CheckoutSdk::TestObject.new
      object.hash_attr = { 'one' => [1, 2, 3, 4], 'two' => [5, 6, 7, 8] }

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(object)

      expect(hash).not_to be nil
      expect(hash.class).to eq(Hash)
      expect(hash['hash_attr']).not_to be nil
      expect(hash['hash_attr']['one']).to eq([1, 2, 3, 4])
      expect(hash['hash_attr']['two']).to eq([5, 6, 7, 8])
    end

    it 'should parse array of Checkout objects into correct hash' do
      obj_one = CheckoutSdk::TestObject.new
      obj_one.string_attr = 'object 1'

      obj_two = CheckoutSdk::TestObject.new
      obj_two.string_attr = 'object 2'

      object = CheckoutSdk::TestObject.new
      object.array_attr = [obj_one, obj_two]

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(object)

      expect(hash).not_to be nil
      expect(hash.class).to eq(Hash)
      expect(hash['array_attr']).not_to be nil
      expect(hash['array_attr'][0]['string_attr']).to eq('object 1')
      expect(hash['array_attr'][1]['string_attr']).to eq('object 2')
    end

    it 'should parse hash of Checkout objects into correct hash' do
      obj_one = CheckoutSdk::TestObject.new
      obj_one.string_attr = 'object 1'

      obj_two = CheckoutSdk::TestObject.new
      obj_two.string_attr = 'object 2'

      object = CheckoutSdk::TestObject.new
      object.hash_attr = { 'one' => obj_one, 'two' => obj_two }

      hash = CheckoutSdk::JsonSerializer.to_custom_hash(object)

      expect(hash).not_to be nil
      expect(hash.class).to eq(Hash)
      expect(hash['hash_attr']).not_to be nil
      expect(hash['hash_attr']['one']['string_attr']).to eq('object 1')
      expect(hash['hash_attr']['two']['string_attr']).to eq('object 2')
    end
  end
end

module CheckoutSdk
  class TestObject
    attr_accessor :string_attr,
                  :number_attr,
                  :bool_attr,
                  :nil_attr,
                  :array_attr,
                  :hash_attr
  end
end
