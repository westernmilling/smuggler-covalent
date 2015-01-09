require 'rails_helper'

RSpec.describe PurchaseOrder::DenormalizedLine, :type => :model do
  describe '.create_instances' do
    let(:purchase_order) do
      po = create(:purchase_order)
      po.lines << create(
        :purchase_order_line, :line_number => 1, :purchase_order => po)
      po.lines << create(
        :purchase_order_line, :line_number => 2, :purchase_order => po)
      po.save!
      po
    end
    subject(:lines) do
      PurchaseOrder::DenormalizedLine.create_instances(purchase_order)
    end

    it 'returns an array' do
      expect(lines).to be_kind_of(Array)
    end

    describe 'first line' do
      subject(:line) { lines[0] }

      its(:earliest_request_date) do
        is_expected.to eq(purchase_order.earliest_request_date)
      end
      its(:latest_request_date) do
        is_expected.to eq(purchase_order.latest_request_date)
      end
      its(:product_reference) do
        is_expected.to eq(purchase_order.lines[0].product.reference)
      end
      its(:purchase_order_number) do
        is_expected.to eq(purchase_order.number)
      end
      its(:purchase_order_date) do
        is_expected.to eq(purchase_order.date)
      end
      its(:quantity) do
        is_expected.to eq(purchase_order.lines[0].quantity)
      end
      its(:ship_to_reference) do
        is_expected.to eq(purchase_order.ship_to_entity.reference)
      end
      its(:unit_price) do
        is_expected.to eq(purchase_order.lines[0].unit_price)
      end
    end

    describe 'second line' do
      subject(:line) { lines[1] }

      its(:earliest_request_date) do
        is_expected.to eq(purchase_order.earliest_request_date)
      end
      its(:latest_request_date) do
        is_expected.to eq(purchase_order.latest_request_date)
      end
      its(:product_reference) do
        is_expected.to eq(purchase_order.lines[1].product.reference)
      end
      its(:purchase_order_number) do
        is_expected.to eq(purchase_order.number)
      end
      its(:purchase_order_date) do
        is_expected.to eq(purchase_order.date)
      end
      its(:quantity) do
        is_expected.to eq(purchase_order.lines[1].quantity)
      end
      its(:ship_to_reference) do
        is_expected.to eq(purchase_order.ship_to_entity.reference)
      end
      its(:unit_price) do
        is_expected.to eq(purchase_order.lines[1].unit_price)
      end
    end
  end
end
