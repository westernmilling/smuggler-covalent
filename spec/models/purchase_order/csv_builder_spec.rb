require 'rails_helper'

RSpec.describe PurchaseOrder::CsvBuilder, :type => :model do 
  def create_po(line_count = 1)
    po = create(:purchase_order) 
    (1..line_count).each do |line_number|
      po.lines << create(:purchase_order_line, :line_number => line_number, :purchase_order => po)
    end
    po.save!
    po
  end
  let(:builder) { PurchaseOrder::CsvBuilder.new }

  describe '.new' do
    subject { builder }

    its(:csv_lines) { is_expected.not_to be_nil }
    its(:csv_lines) { is_expected.to be_empty }
    its(:purchase_orders) { is_expected.not_to be_nil }
    its(:purchase_orders) { is_expected.to be_empty }
  end

  describe '.add' do
    subject { builder.add(create_po) }

    it 'returns the builder' do
      expect(subject).to be_kind_of(PurchaseOrder::CsvBuilder)
    end

    it 'increments the number of purchase orders by one' do
      expect { subject }.to change { builder.purchase_orders.length }.from(0).to(1)
    end
  end

  context 'with one purchase order having a single line' do
    let(:purchase_order) { create_po }
    before { builder.add(purchase_order) }

    describe '.purchase_orders' do
      subject { builder.purchase_orders }

      its(:length) { is_expected.to eq(1) }
    end

    describe '.csv_lines' do
      subject(:lines) { builder.csv_lines }

      its(:length) { is_expected.to eq(2) }

      describe 'first line' do
        subject(:line) { lines[0] }

        it 'is a csv header' do
          po = purchase_order
          expect(line).to eq(builder.fields.join(','))
        end
      end

      describe 'second line' do
        subject(:line) { lines[1] }

        it 'is a csv version of the purchase order' do
          po = purchase_order
          expect(line).to eq("#{po.earliest_request_date},\
#{po.latest_request_date},\
#{po.date},\
#{po.number},\
#{po.ship_to_entity.reference},\
#{po.lines[0].product.reference},\
#{po.lines[0].quantity},\
#{po.lines[0].line_number},\
#{po.lines[0].unit_price}\
")
        end
      end
    end

  end

  context 'with one purchase order having 2 lines' do
    let(:purchase_order) { create_po(2) }
    before { builder.add(purchase_order) }

    describe '.csv_lines' do
      subject(:lines) { builder.csv_lines }

      its(:length) { is_expected.to eq(3) }

      describe 'third line' do
        subject(:line) { lines[2] }

        it 'is a csv version of the purchase order' do
          po = purchase_order
          expect(line).to eq("#{po.earliest_request_date},\
#{po.latest_request_date},\
#{po.date},\
#{po.number},\
#{po.ship_to_entity.reference},\
#{po.lines[1].product.reference},\
#{po.lines[1].quantity},\
#{po.lines[1].line_number},\
#{po.lines[1].unit_price}\
")
        end
      end
    end
  end

  context 'with two purchase orders' do
    before { 
      builder.add(create_po)
      builder.add(create_po)
    }
    subject { builder.purchase_orders }

    describe '.purchase_orders' do
      its(:length) { is_expected.to eq(2) }
    end
  end


  
end