require 'rails_helper'

RSpec.describe UnitOfMeasureTranslation, :type => :model do
  describe 'associations' do
    subject { build(:unit_of_measure_translation) }

    it { is_expected.to belong_to(:unit_of_measure) }
  end

  describe 'validations' do
    subject { build(:unit_of_measure_translation) }

    it { should validate_presence_of(:unit_of_measure) }
    it { should validate_presence_of(:sender_value) }
    it { should validate_presence_of(:source_field) }
    it { should validate_presence_of(:source_value) }
  end

  describe '#translate' do
    before do
      create(
        :unit_of_measure_translation,
        :unit_of_measure => unit_of_measure,
        :sender_value => sender_value,
        :source_value => source_value)
    end
    let(:unit_of_measure) { create(:unit_of_measure) }
    let(:sender_value) { Faker::Number.number(12) }
    let(:source_value) { 'EA' }
    subject(:translate) { UnitOfMeasureTranslation.translate(hash) }

    context 'when a translation exists' do
      let(:hash) do
        {
          :sender => sender_value,
          :uom_basis_of_uom => source_value
        }
      end

      it 'returns a matching product' do
        expect(translate).to eq(unit_of_measure)
      end
    end

    context 'when a translation does not exist' do
      let(:hash) do
        {
          :sender => Faker::Number.number(12),
          :uom_basis_of_uom => source_value }
      end

      it 'returns nil' do
        expect(translate).to be_nil
      end
    end
  end
end
