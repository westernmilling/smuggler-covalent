require 'rails_helper'

RSpec.describe EntityTranslation, :type => :model do
  describe 'associations' do
    subject { build(:entity_translation) }

    it { is_expected.to belong_to(:entity) }
  end

  describe 'validations' do
    subject { build(:entity_translation) }

    it { should validate_presence_of(:entity) }
    it { should validate_presence_of(:sender_value) }
    it { should validate_presence_of(:source_field) }
    it { should validate_presence_of(:source_value) }
  end

  describe '#translate' do
    before do
      create(
        :entity_translation,
        :entity => entity,
        :sender_value => sender_value,
        :source_value => source_value)
    end
    let(:entity) { create(:entity) }
    let(:sender_value) { Faker::Number.number(12) }
    let(:source_value) { Faker::Number.number(11) }
    subject(:translate) { EntityTranslation.translate(hash) }

    context 'with a present translation' do
      let(:hash) do
        {
          :sender => sender_value,
          :ship_to_location => source_value
        }
      end

      it 'returns a matching entity' do
        expect(translate).to eq(entity)
      end
    end

    context 'with no translation present' do
      let(:hash) do
        {
          :sender => Faker::Number.number(12),
          :ship_to_location => source_value
        }
      end

      it 'returns nil' do
        expect(translate).to be_nil
      end
    end
  end
end
