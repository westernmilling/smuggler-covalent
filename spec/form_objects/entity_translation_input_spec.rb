require 'rails_helper'

RSpec.describe EntityTranslationInput, :type => :model do
  subject { EntityTranslationInput.new }

  it { should validate_presence_of(:entity_id) }
  it { should validate_presence_of(:sender_value) }
  it { should validate_presence_of(:source_field) }
  it { should validate_presence_of(:source_value) }

  its(:persisted?) { should be_falsey }

  describe '.save' do
    let(:entity) { create(:entity) }
    let(:sender_value) { Faker::Number.number(12) }
    let(:source_field) { 'Ship-To Location' }
    let(:source_value) { Faker::Number.number(11) }
    let(:input) do
      EntityTranslationInput.new(
        :entity_id => entity.id,
        :sender_value => sender_value,
        :source_field => source_field,
        :source_value => source_value)
    end

    context 'valid input' do
      it 'returns true' do
        expect(input.save).to be_truthy
      end

      # describe 'input' do
      #   it 'has an entity_translation instance' do
      #     input.save
      #     expect(input.entity_translation).to be_present
      #   end
      # end
      # describe 'entity_translation' do
      #   subject(:entity_translation) { input.entity_translation }
      #   it 'has been persisted' do
      #     input.save
      #     expect(entity_translation.persisted?).to be_truthy
      #   end
      # end
      it 'creates a new entity_translation instance' do
        input.save

        expect(input.entity_translation).to be_present
      end

      it 'persists the entity_translation instance' do
        input.save

        expect(input.entity_translation.persisted?).to be_truthy
      end
    end

    context 'invalid input' do
      let(:sender_value) { nil }

      it 'returns false' do
        expect(input.save).to be_falsey
      end
      it 'does not create an entity_translation instance' do
        input.save

        expect(input.entity_translation).not_to be_present
      end
    end
  end
end
