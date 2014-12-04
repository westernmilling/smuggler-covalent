require 'rails_helper'

RSpec.describe QuantityTranslation, :type => :model do
  let(:expression) { nil }
  subject(:quantity_translation) { build(:quantity_translation, :expression => expression) }

  it { should validate_presence_of(:sender_value) }
  it { should validate_presence_of(:expression) }

  describe '.translate' do    
    subject(:translate) { quantity_translation.translate(hash) }
    let(:hash) {  
      { :quantity => 100, :other_value => 5 }
    }

    context 'valid expression' do
      let(:expression) { 'quantity / other_value' }

      it 'translates the value correctly' do
        expect(translate.translated_value).to eq(20)
      end
    end

    context 'invalid expression' do
      let(:expression) { 'quantity *' }

      it 'raises a runtime error' do
        expect { translate }.to raise_exception(RuntimeError, /no rule matched/)
      end
    end
  end

end
