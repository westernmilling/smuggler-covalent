require 'rails_helper'

RSpec.describe CreatePurchaseOrderLine, :type => :interactor do
  let(:product_id) { nil }
  let(:purchase_order_id) { nil }
  let(:quantity) { nil }
  let(:unit_of_measure_id) { nil }
  let(:unit_price) { nil }
  let(:user) { create(:user) }
  subject(:context) do
    with_versioning do
      CreatePurchaseOrderLine.call(
        :product_id => product_id,
        :purchase_order_id => purchase_order_id,
        :quantity => quantity,
        :unit_of_measure_id => unit_of_measure_id,
        :unit_price => unit_price,
        :user => user)
    end
  end

  context 'first line with valid parameters' do
    let(:product_id) { create(:product).id }
    let(:purchase_order_id) { create(:purchase_order).id }
    let(:quantity) { 10 }
    let(:unit_of_measure_id) { create(:unit_of_measure).id }
    let(:unit_price) { 100 }

    describe 'context' do
      its(:success?) { is_expected.to be_truthy }
      its(:message) { is_expected.to match(/success/i) }
      its(:purchase_order_line) { is_expected.to be_present }
    end

    describe PurchaseOrder::Line do
      subject(:purchase_order_line) { context.purchase_order_line }

      its(:persisted?) { is_expected.to be_truthy }
      its(:errors) { is_expected.to be_empty }
      its(:line_number) { is_expected.to eq(1) }

      describe 'papertrail' do
        it 'has 1 version' do
          expect(purchase_order_line.versions.size).to eq(1)
        end
      end
    end
  end

  context 'second line with valid parameters' do
    let(:purchase_order) { create(:purchase_order) }
    before do
      create(
        :purchase_order_line,
        :line_number => 1,
        :purchase_order => purchase_order)
    end

    subject(:purchase_order_line) { context.purchase_order_line }

    its(:line_number) { is_expected.to eq(2) }
  end

  context 'invalid parameters' do
    let(:product_id) { nil }

    describe 'context' do
      its(:failure?) { is_expected.to be_truthy }
      its(:message) { is_expected.to match(/invalid/i) }
      its(:purchase_order_line) { is_expected.to be_present }
    end

    describe PurchaseOrder::Line do
      subject(:purchase_order_line) { context.purchase_order_line }

      its(:persisted?) { is_expected.to be_falsey }
      its(:errors) { is_expected.not_to be_empty }
    end
  end
end
