require 'rails_helper'

RSpec.describe PurchaseOrder::DenormalizedLine, :type => :model do

  describe '.create_instances' do
    let(:purchase_order) { 
      po = create(:purchase_order) 
      po.lines << create(:purchase_order_line, :line_number => 1, :purchase_order => po)
      po.lines << create(:purchase_order_line, :line_number => 2, :purchase_order => po)
      po.save!
      po
    }
    subject(:lines) { PurchaseOrder::DenormalizedLine.create_instances(purchase_order) }

    it 'returns an array' do
      expect(lines).to be_kind_of(Array)
    end

    describe 'first line' do
      subject(:line) { lines[0] }

      its(:earliest_request_date) { is_expected.to eq(purchase_order.earliest_request_date) }
      its(:latest_request_date) { is_expected.to eq(purchase_order.latest_request_date) }
      its(:product_reference) { is_expected.to eq(purchase_order.lines[0].product.reference) }
      its(:purchase_order_number) { is_expected.to eq(purchase_order.number) }
      its(:purchase_order_date) { is_expected.to eq(purchase_order.date) }
      its(:quantity) { is_expected.to eq(purchase_order.lines[0].quantity) }
      its(:ship_to_reference) { is_expected.to eq(purchase_order.ship_to_entity.reference) }
      its(:unit_price) { is_expected.to eq(purchase_order.lines[0].unit_price) }
    end

    describe 'second line' do
      subject(:line) { lines[1] }

      its(:earliest_request_date) { is_expected.to eq(purchase_order.earliest_request_date) }
      its(:latest_request_date) { is_expected.to eq(purchase_order.latest_request_date) }
      its(:product_reference) { is_expected.to eq(purchase_order.lines[1].product.reference) }
      its(:purchase_order_number) { is_expected.to eq(purchase_order.number) }
      its(:purchase_order_date) { is_expected.to eq(purchase_order.date) }
      its(:quantity) { is_expected.to eq(purchase_order.lines[1].quantity) }
      its(:ship_to_reference) { is_expected.to eq(purchase_order.ship_to_entity.reference) }
      its(:unit_price) { is_expected.to eq(purchase_order.lines[1].unit_price) }
    end

  end
end
