require 'rails_helper'

RSpec.describe CreatePurchaseOrder, :type => :interactor do

  let(:date) { nil }
  let(:number) { nil }
  let(:earliest_request_date) { nil }
  let(:latest_request_date) { nil }
  let(:user) { create(:user) }
  subject(:context) { 
    CreatePurchaseOrder.call(
      :ship_to_entity_id => ship_to_entity_id,
      :date => date, 
      :number => number, 
      :earliest_request_date => earliest_request_date,
      :latest_request_date => latest_request_date,
      :user => user)
  }

  context 'valid parameters' do
    let(:date) { Time.now.to_date }
    let(:number) { Faker::Number.number(8) }
    let(:earliest_request_date) { Time.now.to_date }
    let(:latest_request_date) { Time.now.to_date + 1.week }
    let(:ship_to_entity_id) { create(:entity).id }

    describe 'context' do
      its(:success?) { is_expected.to be_truthy }
      its(:message) { is_expected.to match(/success/i) }
      its(:purchase_order) { is_expected.to be_present }
    end

    describe PurchaseOrder do
      subject(:purchase_order) { context.purchase_order }

      its(:persisted?) { is_expected.to be_truthy }
      its(:user) { is_expected.to be_present }
      its(:errors) { is_expected.to be_empty }
    end
  end

  context 'invalid parameters' do
    let(:ship_to_entity_id) { nil }

    describe 'context' do
      its(:failure?) { is_expected.to be_truthy }
      its(:message) { is_expected.to match(/invalid/i) }
      its(:purchase_order) { is_expected.to be_present }      
    end

    describe PurchaseOrder do
      subject(:purchase_order) { context.purchase_order }

      its(:persisted?) { is_expected.to be_falsey }
      its(:errors) { is_expected.not_to be_empty }
    end
  end

end
