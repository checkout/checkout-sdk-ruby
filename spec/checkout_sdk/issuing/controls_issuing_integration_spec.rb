# frozen_string_literal: true

RSpec.describe CheckoutSdk::Issuing do
  include IssuingHelper

  skip 'Avoid creating cards all the time' do
    before(:all) do
      @cardholder = create_cardholder
      @card = create_card @cardholder.id, true
      @control = create_control @card.id
    end

    describe '.create_control' do
      context 'when creating a control with valid data' do
        it { is_valid_control @control }
      end
    end

    describe '.get_card_controls' do
      context 'when retrieving controls for a valid card' do
        it { is_valid_card_controls get_issuing_api.issuing.get_card_controls({ 'target_id' => @card.id }) }
      end
    end

    describe '.get_card_control_details' do
      context 'when retrieving control details for a valid card' do
        it { is_valid_control get_issuing_api.issuing.get_card_control_details @control.id }
      end
    end

    describe '.update_card_control' do
      context 'when updating card control with valid data' do
        it { updates_correctly get_issuing_api.issuing.update_card_control @control.id, get_update_request }
      end
    end

    describe '.remove_card_control' do
      context 'when removing existing card control' do
        it { removes_correctly get_issuing_api.issuing.remove_card_control @control.id }
      end
    end
  end
end

private

def is_valid_control(control)
  assert_response control, %w[id
                              description
                              control_type
                              target_id]

  expect(control.target_id).to eq @card.id
  expect(control.control_type).to eq 'velocity_limit'
end

def is_valid_card_controls(controls)
  assert_response controls, %w[controls]

  controls.controls.each do |control|
    expect(control.target_id).to eq @card.id
  end
end

def updates_correctly(response)
  assert_response response, %w[id
                               description
                               control_type
                               target_id]

  expect(response.target_id).to eq @card.id
  expect(response.control_type).to eq 'velocity_limit'
  expect(response.description).to eq 'New max spend of 1000€ per month for restaurants'
end

def removes_correctly(response)
  assert_response response, %w[id]

  expect(response.id).to eq @control.id
end

def get_update_request
  {
    'description' => 'New max spend of 1000€ per month for restaurants',
    'control_type' => 'velocity_limit',
    'velocity_limit' => {
      'amount_limit' => 10_000,
      'velocity_window' => {
        'type' => 'monthly'
      }
    }
  }
end
