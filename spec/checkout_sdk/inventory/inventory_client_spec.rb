# frozen_string_literal: true

RSpec.describe CheckoutSdk::Inventory do
  let(:credentials_mock) { double('credentials') }
  let(:api_client_mock) { double('api_client') }
  let(:configuration_mock) { double('configuration') }
  let(:client) { CheckoutSdk::Inventory::InventoryClient.new(api_client_mock, configuration_mock) }

  before do
    allow(configuration_mock).to receive(:credentials).and_return(credentials_mock)
    allow(credentials_mock).to receive(:get_authorization).and_return('oauth')
  end

  describe '#adjust_inventory' do
    it 'POSTs typed DTO to inventory/adjustments with idempotency_key' do
      request = CheckoutSdk::Inventory::InventoryAdjustmentRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('inventory/adjustments', 'oauth', request, 'idem-1').and_return('r')
      expect(client.adjust_inventory(request, 'idem-1')).to eq('r')
    end

    it 'POSTs without idempotency_key when omitted' do
      request = CheckoutSdk::Inventory::InventoryAdjustmentRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('inventory/adjustments', 'oauth', request, nil).and_return('r')
      expect(client.adjust_inventory(request)).to eq('r')
    end

    it 'also accepts a raw Hash' do
      hash_request = { 'variant_id' => 'var_1', 'delta' => -1, 'reason' => 'damaged' }
      expect(api_client_mock).to receive(:invoke_post)
        .with('inventory/adjustments', 'oauth', hash_request, nil).and_return('r')
      expect(client.adjust_inventory(hash_request)).to eq('r')
    end
  end

  describe '#create_inventory_reservation' do
    it 'POSTs typed DTO to inventory/reservations with idempotency_key' do
      request = CheckoutSdk::Inventory::InventoryReservationRequest.new
      expect(api_client_mock).to receive(:invoke_post)
        .with('inventory/reservations', 'oauth', request, 'idem-2').and_return('r')
      expect(client.create_inventory_reservation(request, 'idem-2')).to eq('r')
    end
  end

  describe '#get_inventory_reservation' do
    it 'GETs inventory/reservations/{id}' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('inventory/reservations/rsv_1', 'oauth').and_return('r')
      expect(client.get_inventory_reservation('rsv_1')).to eq('r')
    end
  end

  describe '#commit_inventory_reservation' do
    it 'POSTs to inventory/reservations/{id}/commit with no body' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('inventory/reservations/rsv_1/commit', 'oauth').and_return('r')
      expect(client.commit_inventory_reservation('rsv_1')).to eq('r')
    end
  end

  describe '#release_inventory_reservation' do
    it 'POSTs to inventory/reservations/{id}/release with no body' do
      expect(api_client_mock).to receive(:invoke_post)
        .with('inventory/reservations/rsv_1/release', 'oauth').and_return('r')
      expect(client.release_inventory_reservation('rsv_1')).to eq('r')
    end
  end

  describe '#get_inventory_levels' do
    it 'GETs inventory/{variant_id} with no params by default' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('inventory/var_1', 'oauth', nil).and_return('r')
      expect(client.get_inventory_levels('var_1')).to eq('r')
    end

    it 'GETs inventory/{variant_id} with expand=product when requested' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('inventory/var_1', 'oauth', { expand: 'product' }).and_return('r')
      expect(client.get_inventory_levels('var_1', expand_product: true)).to eq('r')
    end
  end

  describe '#set_inventory_levels' do
    it 'PUTs typed DTO to inventory/{variant_id}' do
      request = CheckoutSdk::Inventory::InventorySetLevelsRequest.new
      expect(api_client_mock).to receive(:invoke_put)
        .with('inventory/var_1', 'oauth', request).and_return('r')
      expect(client.set_inventory_levels('var_1', request)).to eq('r')
    end
  end

  describe '#get_inventory_product' do
    it 'GETs inventory/{variant_id}/product' do
      expect(api_client_mock).to receive(:invoke_get)
        .with('inventory/var_1/product', 'oauth').and_return('r')
      expect(client.get_inventory_product('var_1')).to eq('r')
    end
  end

  describe '#set_inventory_product' do
    it 'PUTs typed DTO to inventory/{variant_id}/product' do
      request = CheckoutSdk::Inventory::InventorySetProductRequest.new
      expect(api_client_mock).to receive(:invoke_put)
        .with('inventory/var_1/product', 'oauth', request).and_return('r')
      expect(client.set_inventory_product('var_1', request)).to eq('r')
    end
  end

  describe '#delete_inventory_product' do
    it 'DELETEs inventory/{variant_id}/product' do
      expect(api_client_mock).to receive(:invoke_delete)
        .with('inventory/var_1/product', 'oauth').and_return('r')
      expect(client.delete_inventory_product('var_1')).to eq('r')
    end
  end
end
