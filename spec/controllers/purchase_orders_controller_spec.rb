require 'rails_helper'

RSpec.describe PurchaseOrdersController, :type => :controller do
  before { sign_in(create(:user)) }
  let(:purchase_order) {
    po = create(:purchase_order)
    (1..2).each do |line_number|
      po.lines << create(:purchase_order_line, :line_number => line_number, :purchase_order => po)
    end
    po.save!
    po
  }

  context 'when format is html' do
    describe 'GET show' do
      it 'assigns @purchase_order' do
        get :show, :id => purchase_order.id, :format => :html
        expect(assigns(:purchase_order)).to eq(purchase_order)
      end
    end
  end

  context 'when format is csv' do
    let(:csv_string) {
      builder = PurchaseOrder::CsvBuilder.new
      builder.add(purchase_order)
      builder.csv_lines.join("\n")
    }
    let(:csv_options) {
      { 
        :filename => "purchase_order.csv",
        :disposition => 'attachment',
        :type => 'text/csv; charset=utf-8; header=present'
      }
    }

    describe 'GET show' do
      it 'returns a csv attachment' do
        expect(@controller).to receive(:send_data).
          with(csv_string, csv_options) do
            # to prevent a 'missing template' error
            @controller.render nothing: true
          end

        get :show, :id => purchase_order.id, format: :csv
      end
    end
  end
end
