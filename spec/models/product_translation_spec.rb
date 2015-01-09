require 'rails_helper'

RSpec.describe ProductTranslation, :type => :model do
  describe 'associations' do
    subject { build(:product_translation) }

    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    subject { build(:product_translation) }

    it { is_expected.to validate_presence_of(:product) }
    it { is_expected.to validate_presence_of(:sender_value) }
    it { is_expected.to validate_presence_of(:source_field) }
    it { is_expected.to validate_presence_of(:source_value) }
  end

  describe '#translate' do
    before do
      create(
        :product_translation,
        :product => product,
        :sender_value => sender_value,
        :source_value => source_value)
    end
    let(:product) { create(:product) }
    let(:sender_value) { Faker::Number.number(12) }
    let(:source_value) { Faker::Number.number(9) }
    subject(:translate) { ProductTranslation.translate(hash) }

    context 'when a translation exists' do
      let(:hash) do
        {
          :po_number => Faker::Number.number(10),
          :line_nbr => 1,
          :sender => sender_value,
          :buyer_item_nbr => source_value
        }
      end

      its(:success) { is_expected.to be_truthy }
      its(:value) { is_expected.to eq(product) }
    end

    context 'when a translation does not exist' do
      let(:hash) do
        {
          :po_number => Faker::Number.number(10),
          :line_nbr => 1,
          :sender => Faker::Number.number(12),
          :buyer_item_nbr => source_value }
      end

      its(:success) { is_expected.to be_falsey }
      its(:message) do
        is_expected.to(
          eq(I18n.t('default.error',
                    :name => 'product',
                    :purchase_order_number => hash[:po_number],
                    :line_number => hash[:line_nbr],
                    :scope => :field_translation))
        )
      end
    end
  end
end
