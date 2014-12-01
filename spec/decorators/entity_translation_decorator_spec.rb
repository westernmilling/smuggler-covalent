require 'rails_helper'

RSpec.describe EntityTranslationDecorator, :type => :decorator do
  let(:entity) { build(:entity) }
  let(:entity_translation) { build(:entity_translation, :entity => entity) }
  # subject ( entity.decorate )
  subject(:decorator) { entity_translation.decorate }

  its(:entity_string) { should eq(entity.cached_full_name) }

  # describe '.entity_string' do
  #   subject { decorator.entity_string }

  #   it 'should equal the entity cached_full_name' do
  #     expect(subject).to eq(entity.cached_full_name)
  #   end
  # end
end
