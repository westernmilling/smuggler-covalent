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
          :sender => sender_value,
          :buyer_item_nbr => source_value
        }
      end

      it 'returns a matching product' do
        expect(translate).to eq(product)
      end
    end

    context 'when a translation does not exist' do
      let(:hash) do
        {
          :sender => Faker::Number.number(12),
          :buyer_item_nbr => source_value }
      end

      it 'returns nil' do
        expect(translate).to be_nil
      end
    end
  end
end
