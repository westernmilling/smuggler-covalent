require 'rails_helper'

RSpec.describe Import::ProcessBatch, :type => :interactor do
  before do
    create(
      :price_translation,
      :sender_value => sender_value,
      :expression => 'unit_price * quantity')
    create(
      :quantity_translation,
      :sender_value => sender_value,
      :expression => 'quantity / dtl_user_defined_field3')
  end
  let(:batch) do
    temp_batch = build(:import_batch, :status => batch_status)
    temp_batch.upload = import_file
    with_versioning { temp_batch.save! }
    temp_batch
  end
  let(:batch_id) { batch.id }
  let(:batch_status) { :new }
  let(:context) { interactor }
  let(:entity_translation) do
    create(
      :entity_translation,
      :entity => create(:entity),
      :sender_value => sender_value,
      :source_value => ship_to_location)
  end
  let(:import_data) { [] }
  let(:import_lines) { create_import_file_lines(import_data) }
  let(:import_file) { create_import_file(import_lines) }
  let(:ship_to_location) { Faker::Number.number(11) }
  let(:unit_of_measure) { create(:unit_of_measure) }
  subject(:interactor) { Import::ProcessBatch.call(:batch_id => batch_id) }

  describe '#call' do
    let(:product_translation_1) do
      create(
        :product_translation,
        :product => create(:product),
        :sender_value => sender_value,
        :source_value => Faker::Number.number(9))
    end
    let(:product_translation_2) do
      create(
        :product_translation,
        :product => create(:product),
        :sender_value => sender_value,
        :source_value => Faker::Number.number(9))
    end
    let(:sender_value) { Faker::Number.number(12) }
    let(:unit_of_measure_translation) do
      create(
        :unit_of_measure_translation,
        :sender_value => sender_value,
        :unit_of_measure => unit_of_measure)
    end

    context 'when batch is new' do
      let(:batch_status) { :new }
      let(:import_data) do
        [
          {
            :number => Faker::Number.number(10),
            :lines => [
              {
                :buyer_item_number => product_translation_1.source_value,
                :uom_basis_of_uom => unit_of_measure_translation.source_value
              },
              {
                :buyer_item_number => product_translation_2.source_value,
                :uom_basis_of_uom => unit_of_measure_translation.source_value
              }
            ],
            :sender => entity_translation.sender_value,
            :ship_to_location => ship_to_location
          }
        ]
      end

      describe 'context' do
        subject { context }

        its(:success?) { is_expected.to be_truthy }
        its(:message) { is_expected.to match(/batch proccessed successfully/i) }
        its(:batch) { is_expected.to be_present }
      end

      describe Import::Batch do
        subject { context.batch }

        its(:status) { is_expected.to eq(:complete) }
      end

      describe 'batch lines' do
        subject { context.batch.lines }

        its(:any?) { is_expected.to be_truthy }
        its(:size) { is_expected.to eq(2) }
      end

      describe 'first line' do
        subject { context.batch.lines[0] }

        its(:present?) { is_expected.to be_truthy }
        its(:purchase_order_number) do
          is_expected.to eq(import_data.first[:number])
        end
      end

      describe 'first line field values' do
        subject { context.batch.lines[0].values }

        its(:present?) { is_expected.to be_truthy }
        its(:any?) { is_expected.to be_truthy }
      end
    end

    context 'when batch is failed' do
      let(:batch_status) { :failed }

      describe 'context' do
        its(:success?) { is_expected.to be_truthy }
      end
    end

    context 'when batch is pending' do
      let(:batch_status) { :pending }

      describe 'interactor' do
        it 'raises exception cannot process a pending batch' do
          expect { interactor }.to raise_exception(
            'Cannot process a pending batch')
        end
      end
    end

    context 'when batch is complete' do
      let(:batch_status) { :complete }

      describe 'interactor' do
        it 'raises exception cannot process a complete batch' do
          expect { interactor }.to raise_exception(
            'Cannot process a complete batch')
        end
      end
    end

    context 'when a failing batch is processed a second time' do
      before do
        Import::ProcessBatch.call(:batch_id => batch_id)
      end
      let(:batch_status) { :new }
      let(:import_data) do
        [
          {
            :number => Faker::Number.number(10),
            :lines => [
              {
                :buyer_item_number => product_translation_1.source_value,
                :uom_basis_of_uom => 'EA'
              }
            ],
            :sender => Faker::Number.number(12),
            :ship_to_location => ship_to_location
          }
        ]
      end

      describe 'context' do
        subject { context }

        its(:failure?) { is_expected.to be_truthy }
        its(:message) { is_expected.to match(/batch proccess failed/i) }
        its(:batch) { is_expected.to be_present }
      end

      describe Import::Batch do
        subject { context.batch }

        its(:status) { is_expected.to eq(:failed) }
      end

      describe 'batch lines' do
        subject { context.batch.lines }

        its(:any?) { is_expected.to be_truthy }
        its(:size) { is_expected.to eq(1) }

        describe 'first' do
          subject { context.batch.lines[0] }

          its(:present?) { is_expected.to be_truthy }
          its(:status) { is_expected.to eq(:failed) }
        end
      end

      describe 'purchase orders' do
        subject(:purchase_orders) { context.purchase_orders }

        its(:any?) { is_expected.to be_falsey }
      end
    end

    context 'when batch has a single purchase order' do
      let(:import_data) do
        [
          {
            :number => Faker::Number.number(10),
            :lines => [
              {
                :buyer_item_number => product_translation_1.source_value,
                :uom_basis_of_uom => unit_of_measure_translation.source_value
              },
              {
                :buyer_item_number => product_translation_2.source_value,
                :uom_basis_of_uom => unit_of_measure_translation.source_value
              }
            ],
            :sender => entity_translation.sender_value,
            :ship_to_location => ship_to_location
          }
        ]
      end

      describe 'purchase orders' do
        subject(:purchase_orders) { context.purchase_orders }

        its(:present?) { is_expected.to be_truthy }
        its(:length) { is_expected.to eq(1) }
      end

      describe 'purchase_order' do
        subject(:purchase_order) { context.purchase_orders.first }

        its(:number) { is_expected.to eq(import_data.first[:number]) }
        it 'has 2 lines' do
          expect(purchase_order.lines.length).to eq(2)
        end
      end

      describe 'first purchase order line' do
        subject(:line) { context.purchase_orders[0].lines[0] }

        its(:product) { is_expected.to eq(product_translation_1.product) }
      end

      describe 'second purchase order line' do
        subject(:line) { context.purchase_orders[0].lines[1] }

        its(:product) { is_expected.to eq(product_translation_2.product) }
      end
    end

    context 'when batch has two purchase orders' do
      let(:import_data) do
        [
          {
            :number => Faker::Number.number(10),
            :lines => [
              {
                :buyer_item_number => product_translation_1.source_value,
                :uom_basis_of_uom => unit_of_measure_translation.source_value
              }
            ],
            :sender => entity_translation.sender_value,
            :ship_to_location => ship_to_location
          },
          {
            :number => Faker::Number.number(10),
            :lines => [
              {
                :buyer_item_number => product_translation_1.source_value,
                :uom_basis_of_uom => unit_of_measure_translation.source_value
              }],
            :sender => entity_translation.sender_value,
            :ship_to_location => ship_to_location
          }
        ]
      end

      describe 'purchase orders' do
        subject(:purchase_orders) { context.purchase_orders }

        its(:present?) { is_expected.to be_truthy }
        its(:length) { is_expected.to eq(2) }
      end
    end

    context 'when translation information is missing' do
      let(:batch_status) { :new }
      let(:import_data) do
        [
          {
            :number => Faker::Number.number(10),
            :lines => [
              {
                :buyer_item_number => product_translation_1.source_value,
                :uom_basis_of_uom => 'EA'
              }
            ],
            :sender => Faker::Number.number(12),
            :ship_to_location => ship_to_location
          }
        ]
      end

      describe 'context' do
        subject { context }

        its(:failure?) { is_expected.to be_truthy }
        its(:message) { is_expected.to match(/batch proccess failed/i) }
        its(:batch) { is_expected.to be_present }
      end

      describe Import::Batch do
        subject { context.batch }

        its(:status) { is_expected.to eq(:failed) }
      end

      describe 'batch lines' do
        subject { context.batch.lines }

        its(:any?) { is_expected.to be_truthy }
        its(:size) { is_expected.to eq(1) }

        describe 'first' do
          subject { context.batch.lines[0] }

          its(:present?) { is_expected.to be_truthy }
          its(:status) { is_expected.to eq(:failed) }
        end
      end

      describe 'batch remarks' do
        subject(:remarks) { context.batch.remarks }

        its(:any?) { is_expected.to be_truthy }

        describe 'entity translation' do
          subject(:first) do
            remarks.find_by(:remark_category => 'EntityTranslation')
          end

          its(:present?) { is_expected.to be_truthy }
          its(:remark_message) do
            is_expected.to(
              eq(I18n.t('default.error',
                        :name => 'entity',
                        :purchase_order_number => import_data[0][:number],
                        :line_number => 1,
                        :scope => :field_translation))
            )
          end
          its(:remark_type) { is_expected.to eq(:error) }
        end

        describe 'price translation' do
          subject(:first) do
            remarks.find_by(:remark_category => 'PriceTranslation')
          end

          its(:present?) { is_expected.to be_truthy }
          its(:remark_message) do
            is_expected.to(
              eq(I18n.t('default.error',
                        :name => 'price',
                        :purchase_order_number => import_data[0][:number],
                        :line_number => 1,
                        :scope => :field_translation))
            )
          end
          its(:remark_type) { is_expected.to eq(:error) }
        end

        describe 'product translation' do
          subject(:first) do
            remarks.find_by(:remark_category => 'ProductTranslation')
          end

          its(:present?) { is_expected.to be_truthy }
          its(:remark_message) do
            is_expected.to(
              eq(I18n.t('default.error',
                        :name => 'product',
                        :purchase_order_number => import_data[0][:number],
                        :line_number => 1,
                        :scope => :field_translation))
            )
          end
          its(:remark_type) { is_expected.to eq(:error) }
        end

        describe 'quantity translation' do
          subject(:first) do
            remarks.find_by(:remark_category => 'QuantityTranslation')
          end

          its(:present?) { is_expected.to be_truthy }
          its(:remark_message) do
            is_expected.to(
              eq(I18n.t('default.error',
                        :name => 'quantity',
                        :purchase_order_number => import_data[0][:number],
                        :line_number => 1,
                        :scope => :field_translation))
            )
          end
          its(:remark_type) { is_expected.to eq(:error) }
        end

        describe 'unit of measure translation' do
          subject(:first) do
            remarks.find_by(:remark_category => 'UnitOfMeasureTranslation')
          end

          its(:present?) { is_expected.to be_truthy }
          its(:remark_message) do
            is_expected.to(
              eq(I18n.t('default.error',
                        :name => 'unit of measure',
                        :purchase_order_number => import_data[0][:number],
                        :line_number => 1,
                        :scope => :field_translation))
            )
          end
          its(:remark_type) { is_expected.to eq(:error) }
        end

        describe 'purchase orders' do
          subject(:purchase_orders) { context.purchase_orders }

          its(:any?) { is_expected.to be_falsey }
        end
      end
    end
  end
end
