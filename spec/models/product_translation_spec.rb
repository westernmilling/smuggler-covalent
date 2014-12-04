require 'rails_helper'

RSpec.describe ProductTranslation, :type => :model do
  subject { build(:product_translation) }

  it { should validate_presence_of(:product) }
  it { should validate_presence_of(:sender_value) }
  it { should validate_presence_of(:source_field) }
  it { should validate_presence_of(:source_value) }

  describe '.translate' do
    let(:product) { create(:product) }
    let(:translation) { 
      create(:product_translation, 
        :product => product, 
        :sender_value => sender_value, 
        :source_field => source_field,
        :source_value => source_value)
    }
    let(:sender_value) { Faker::Number.number(12) }
    let(:source_field) { 'buyer_item_nbr' }
    let(:source_value) { Faker::Number.number(9) }    
    subject(:translate) { translation.translate(hash) }

    context 'with a present translation' do
      let(:hash) {  
        { :sender_value => sender_value, 
          :source_field => source_field, 
          :source_value => source_value }
      }

      it 'has a translated_value' do
        expect(translate.translated_value).to eq(product)
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
