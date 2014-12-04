require 'rails_helper'

RSpec.describe EntityTranslation, :type => :model do
  subject { build(:entity_translation) }

  it { should validate_presence_of(:entity) }
  it { should validate_presence_of(:sender_value) }
  it { should validate_presence_of(:source_field) }
  it { should validate_presence_of(:source_value) }

  describe '.translate' do
    let(:entity) { create(:entity) }
    let(:translation) { 
      create(:entity_translation, 
        :entity => entity, 
        :sender_value => sender_value, 
        :source_field => source_field,
        :source_value => source_value)
    }
    let(:sender_value) { Faker::Number.number(12) }
    let(:source_field) { 'ship-to_location' }
    let(:source_value) { Faker::Number.number(11) }    
    subject(:translate) { translation.translate(hash) }

    context 'with a present translation' do
      let(:hash) {  
        { :sender_value => sender_value, 
          :source_field => source_field, 
          :source_value => source_value }
      }

      it 'has a translated_value' do
        expect(translate.translated_value).to eq(entity)
      end
    end

    context 'with no translation present' do
      let(:hash) {  
        { :sender_value => Faker::Number.number(12), 
          :source_field => source_field, 
          :source_value => source_value }
      }  

      it 'does not have a translated_value' do
        expect(translate.translated_value).to be_nil
      end
    end

  end
end
